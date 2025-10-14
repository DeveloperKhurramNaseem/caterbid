part of 'login_bloc.dart';

sealed class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class LoginButtonPressed extends LoginEvent {
  final LoginRequestModel model;

  const LoginButtonPressed(this.model);

  @override
  List<Object?> get props => [model];
}
