part of 'login_bloc.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {
  final LoginResponseModel user;

  const LoginSuccess(this.user);

  @override
  List<Object?> get props => [user];
}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class LoginOTPNotVerified extends LoginState {
  final String message;
  final String email;

  const LoginOTPNotVerified(this.message, this.email);

  @override
  List<Object?> get props => [message, email];
}

class LoginEmailNotVerified extends LoginState {
  final EmailNotVerifiedModel user;

  const LoginEmailNotVerified(this.user);

  @override
  List<Object?> get props => [user];
}