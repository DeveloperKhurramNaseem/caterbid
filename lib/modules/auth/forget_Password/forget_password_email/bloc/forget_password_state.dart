part of 'forget_password_bloc.dart';

sealed class ForgetPasswordState extends Equatable {
  const ForgetPasswordState();

  @override
  List<Object> get props => [];
}

final class ForgetPasswordInitial extends ForgetPasswordState {}

final class ForgetPasswordLoading extends ForgetPasswordState {}

class ForgetPasswordSuccess extends ForgetPasswordState {
  final String email;

  const ForgetPasswordSuccess(this.email);

  @override
  List<Object> get props => [email];
}

class ForgetPasswordFailure extends ForgetPasswordState {
  final String message;

  const ForgetPasswordFailure(this.message);

  @override
  List<Object> get props => [message];
}
