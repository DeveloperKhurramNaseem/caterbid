import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:caterbid/modules/Restaurant/account_settings/account_security_settings/change_password/model/change_password_request.dart';
import 'package:caterbid/modules/Restaurant/account_settings/account_security_settings/change_password/repository/change_password_repository.dart';

part 'provider_change_password_event.dart';
part 'provider_change_password_state.dart';

class ProviderChangePasswordBloc extends Bloc<ProviderChangePasswordEvent, ProviderChangePasswordState> {
  final ProviderChangePasswordRepository repo;

  ProviderChangePasswordBloc(this.repo) : super(ProviderChangePasswordInitial()) {
    on<ValidatePasswordEvent>(_onValidatePassword);
    on<SubmitChangePasswordEvent>(_onSubmit);
    on<ResetPasswordStateEvent>((event, emit) => emit(ProviderChangePasswordInitial()));
  }

  void _onValidatePassword(
      ValidatePasswordEvent event, Emitter<ProviderChangePasswordState> emit) {
    final password = event.newPassword;
    final confirmPassword = event.confirmPassword;

    final isValidLength = password.length >= 8;
    final hasUpperCase = password.contains(RegExp(r'[A-Z]'));
    final hasLowerCase = password.contains(RegExp(r'[a-z]'));
    final hasNumberOrSymbol = password.contains(RegExp(r'[0-9!@#\$%^&*(),.?":{}|<>]'));

    final isPasswordValid = isValidLength && hasUpperCase && hasLowerCase && hasNumberOrSymbol;
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
      SubmitChangePasswordEvent event, Emitter<ProviderChangePasswordState> emit) async {
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
      await repo.changePassword(ProviderChangePasswordRequest(
        currentPassword: event.currentPassword,
        newPassword: event.newPassword,
      ));

      emit(ProviderChangePasswordSuccess());
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to update password: $e',
      ));
    }
  }
}
