import 'package:bloc/bloc.dart';
import 'package:caterbid/core/network/api_exception.dart';
import 'package:caterbid/core/utils/helpers/secure_storage.dart';
import 'package:caterbid/core/utils/prefs/shared_preferences.dart';
import 'package:caterbid/modules/auth/login/model/Email_not_Verified_model.dart';
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
      final result = await repository.login(event.model);

      // Handle Email Not Verified
      if (result is EmailNotVerifiedModel) {
        emit(LoginEmailNotVerified(result));
        return;
      }

      // Normal login success
      final user = result as LoginResponseModel;
      await SecureStorage.saveToken(user.token);


      emit(LoginSuccess(user));
    } catch (error) {
      final apiError = ApiErrorHandler.handle(error);
      emit(LoginFailure(apiError.message));
    }
  }
}
