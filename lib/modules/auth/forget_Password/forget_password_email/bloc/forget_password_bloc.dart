import 'package:bloc/bloc.dart';
import 'package:caterbid/core/network/api_exception.dart';
import 'package:caterbid/modules/auth/forget_Password/forget_password_email/model/forget_password_request.dart';
import 'package:caterbid/modules/auth/forget_Password/forget_password_email/repository/forget_password_repository.dart';
import 'package:equatable/equatable.dart';

part 'forget_password_event.dart';
part 'forget_password_state.dart';

class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  final ForgetpasswordRepository repository;

  ForgetPasswordBloc(this.repository) : super(ForgetPasswordInitial()) {
    on<SubmitForgetPasswordEmail>(_onSubmitForgetPasswordEmail);
  }

  Future<void> _onSubmitForgetPasswordEmail(
    SubmitForgetPasswordEmail event,
    Emitter<ForgetPasswordState> emit,
  ) async {
    emit(ForgetPasswordLoading());

    try {
      // API call using the model
      final response = await repository.forgetPassword(event.model);

      // You can return email from model directly or API response if it includes one
      emit(ForgetPasswordSuccess(event.model.email));
    } catch (error) {
      final apiError = ApiErrorHandler.handle(error);
      emit(ForgetPasswordFailure(apiError.message));
    }
  }
}
