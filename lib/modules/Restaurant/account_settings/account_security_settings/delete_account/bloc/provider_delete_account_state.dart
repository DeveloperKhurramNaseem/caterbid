part of 'provider_delete_account_bloc.dart';

sealed class ProviderDeleteAccountState extends Equatable {
  const ProviderDeleteAccountState();
  
  @override
  List<Object> get props => [];
}

final class ProviderDeleteAccountInitial extends ProviderDeleteAccountState {}

class ProvidorDeleteAccountLoading extends ProviderDeleteAccountState {}

class ProvidorDeleteAccountSuccess extends ProviderDeleteAccountState {
  final String message;

  const ProvidorDeleteAccountSuccess(this.message);

  @override
  List<Object> get props => [message];
}


class ProvidorDeleteAccountFailure extends ProviderDeleteAccountState {
  final String error;

  const ProvidorDeleteAccountFailure(this.error);

  @override
  List<Object> get props => [error];
}