part of 'change_password_request_bloc.dart';

sealed class ChangePasswordRequestState extends Equatable {
  const ChangePasswordRequestState();
  
  @override
  List<Object> get props => [];
}

final class ChangePasswordRequestInitial extends ChangePasswordRequestState {}



class ChangePasswordInitial extends ChangePasswordRequestState {}

class ChangePasswordLoading extends ChangePasswordRequestState {}

class ChangePasswordSuccess extends ChangePasswordRequestState {}

class ChangePasswordFailure extends ChangePasswordRequestState {
  final String message;

  const ChangePasswordFailure(this.message);

  @override
  List<Object> get props => [message];
}
