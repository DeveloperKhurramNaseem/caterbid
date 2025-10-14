import 'package:bloc/bloc.dart';
import 'package:caterbid/core/network/api_exception.dart';
import 'package:caterbid/modules/auth/signup/bloc/sign_up_state.dart';
import 'package:caterbid/modules/auth/signup/model/signup_request.dart';
import 'package:caterbid/modules/auth/signup/repository/signup_repository.dart';
import 'package:meta/meta.dart';

part 'sign_up_event.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final SignUpRepository repository;

  SignUpBloc(this.repository) : super(SignUpInitial()) {
    on<SignUpButtonPressed>(_onSignUp);
  }

  Future<void> _onSignUp(
      SignUpButtonPressed event, Emitter<SignUpState> emit) async {
    emit(SignUpLoading());
    try {
      final response = await repository.signUp(event.model);
      emit(SignUpSuccess(response));
    } catch (error) {
      final apiError = ApiErrorHandler.handle(error);
      emit(SignUpFailure(apiError.message));
    }
  }
}
