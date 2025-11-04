part of 'requestee_delete_account_bloc.dart';

sealed class RequesteeDeleteAccountState extends Equatable {
  const RequesteeDeleteAccountState();
  
  @override
  List<Object> get props => [];
}

final class RequesteeDeleteAccountInitial extends RequesteeDeleteAccountState {}

class RequesteeDeleteAccountLoading extends RequesteeDeleteAccountState {}

class RequesteeDeleteAccountSuccess extends RequesteeDeleteAccountState {
  final String message;

  const RequesteeDeleteAccountSuccess(this.message);

  @override
  List<Object> get props => [message];
}

class RequesteeDeleteAccountFailure extends RequesteeDeleteAccountState {
  final String error;

  const RequesteeDeleteAccountFailure(this.error);

  @override
  List<Object> get props => [error];
}