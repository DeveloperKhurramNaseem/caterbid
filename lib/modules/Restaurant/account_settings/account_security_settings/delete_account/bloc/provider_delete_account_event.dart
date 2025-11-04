part of 'provider_delete_account_bloc.dart';

sealed class ProviderDeleteAccountEvent extends Equatable {
  const ProviderDeleteAccountEvent();

  @override
  List<Object> get props => [];
}
class ProviderDeleteAccountRequested extends ProviderDeleteAccountEvent {}
