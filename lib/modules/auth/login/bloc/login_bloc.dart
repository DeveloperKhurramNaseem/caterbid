import 'package:bloc/bloc.dart';
import 'package:caterbid/core/utils/helpers/secure_storage.dart';
import 'package:caterbid/modules/auth/login/model/login_request_model.dart';
import 'package:caterbid/modules/auth/login/model/login_response_model.dart';
import 'package:caterbid/modules/auth/login/repository/login_repository.dart';
import 'package:equatable/equatable.dart';


part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository repository;

  LoginBloc(this.repository) : super(LoginInitial()) {
    on<LoginButtonPressed>(_onLoginButtonPressed);
  }

  Future<void> _onLoginButtonPressed(
    LoginButtonPressed event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoading());
    try {
      final user = await repository.login(event.model);

      // Token in Secure Storage
      await SecureStorage.saveToken(user.token);

      emit(LoginSuccess(user));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}
