part of 'requestee_delete_account_bloc.dart';

sealed class RequesteeDeleteAccountEvent extends Equatable {
  const RequesteeDeleteAccountEvent();

  @override
  List<Object> get props => [];
}

class RequesteeDeleteAccountRequested extends RequesteeDeleteAccountEvent {}
