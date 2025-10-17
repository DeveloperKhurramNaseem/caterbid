part of 'change_password_request_bloc.dart';

sealed class ChangePasswordRequestEvent extends Equatable {
  const ChangePasswordRequestEvent();

  @override
  List<Object> get props => [];
}

class SubmitChangePassword extends ChangePasswordRequestEvent {
  final ChangePasswordRequest request;

  const SubmitChangePassword(this.request);

  @override
  List<Object> get props => [request];
}