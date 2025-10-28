import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:caterbid/modules/Producer/account_settings/account_security_settings/change_password/model/requestee_change_password_request.dart';
import 'package:caterbid/modules/Producer/account_settings/account_security_settings/change_password/repository/requestee_change_password.dart';

part 'change_password_event.dart';
part 'change_password_state.dart';

class ChangePasswordBloc extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  final RequesteeChangePasswordRepository repo;

  ChangePasswordBloc(this.repo) : super(ChangePasswordInitial()) {
    on<ValidatePasswordEvent>(_onValidatePassword);
    on<SubmitChangePasswordEvent>(_onSubmit);
    on<ResetPasswordStateEvent>((event, emit) {
      emit(ChangePasswordInitial());
    });
  }

  void _onValidatePassword(
      ValidatePasswordEvent event, Emitter<ChangePasswordState> emit) {
    final password = event.newPassword;
    final confirmPassword = event.confirmPassword;

    final isValidLength = password.length >= 8;
    final hasUpperCase = password.contains(RegExp(r'[A-Z]'));
    final hasLowerCase = password.contains(RegExp(r'[a-z]'));
    final hasNumberOrSymbol =
        password.contains(RegExp(r'[0-9!@#\$%^&*(),.?":{}|<>]'));

    final isPasswordValid =
        isValidLength && hasUpperCase && hasLowerCase && hasNumberOrSymbol;
    final isConfirmMatched = password == confirmPassword;

    emit(state.copyWith(
      isValidLength: isValidLength,
      hasUpperCase: hasUpperCase,
      hasLowerCase: hasLowerCase,
      hasNumberOrSymbol: hasNumberOrSymbol,
      isPasswordValid: isPasswordValid,
      isButtonEnabled: isPasswordValid && isConfirmMatched,
      errorMessage: null,
    ));
  }

  Future<void> _onSubmit(
      SubmitChangePasswordEvent event, Emitter<ChangePasswordState> emit) async {
    if (event.currentPassword.isEmpty ||
        event.newPassword.isEmpty ||
        event.confirmPassword.isEmpty) {
      emit(state.copyWith(errorMessage: 'Please fill in all fields.'));
      return;
    }

    if (event.newPassword != event.confirmPassword) {
      emit(state.copyWith(errorMessage: 'Passwords do not match.'));
      return;
    }

    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      await repo.changePassword(RequesteeChangePasswordRequest(
        currentPassword: event.currentPassword,
        newPassword: event.newPassword,
      ));

      emit(ChangePasswordSuccess());
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to update password: $e',
      ));
    }
  }
}
