part of 'provider_change_password_bloc.dart';

abstract class ProviderChangePasswordEvent extends Equatable {
  const ProviderChangePasswordEvent();
  @override
  List<Object?> get props => [];
}

class ValidatePasswordEvent extends ProviderChangePasswordEvent {
  final String newPassword;
  final String confirmPassword;

  const ValidatePasswordEvent(this.newPassword, this.confirmPassword);

  @override
  List<Object?> get props => [newPassword, confirmPassword];
}

class SubmitChangePasswordEvent extends ProviderChangePasswordEvent {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  const SubmitChangePasswordEvent({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  @override
  List<Object?> get props => [currentPassword, newPassword, confirmPassword];
}

class ResetPasswordStateEvent extends ProviderChangePasswordEvent {}
