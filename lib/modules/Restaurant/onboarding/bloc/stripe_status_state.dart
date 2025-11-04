part of 'stripe_status_bloc.dart';

sealed class StripeStatusState extends Equatable {
  const StripeStatusState();
  
  @override
  List<Object> get props => [];
}

final class StripeStatusInitial extends StripeStatusState {}

class StripeStatusLoading extends StripeStatusState {}

class StripeStatusLoaded extends StripeStatusState {
  final bool connected;
  final String? connectUrl;
  final String? accountId;

  const StripeStatusLoaded({required this.connected, this.connectUrl, this.accountId});

  @override
  List<Object> get props => [connected, connectUrl ?? '', accountId ?? ''];
}

class StripeStatusError extends StripeStatusState {
  final String message;
  const StripeStatusError({required this.message});

  @override
  List<Object> get props => [message];
}