part of 'change_password_bloc.dart';

abstract class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();
  @override
  List<Object?> get props => [];
}

// When user types new password
class ValidatePasswordEvent extends ChangePasswordEvent {
  final String newPassword;
  final String confirmPassword;

  const ValidatePasswordEvent(this.newPassword, this.confirmPassword);

  @override
  List<Object?> get props => [newPassword];
}

// When user presses Change Password
class SubmitChangePasswordEvent extends ChangePasswordEvent {
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

class ResetPasswordStateEvent extends ChangePasswordEvent {}
