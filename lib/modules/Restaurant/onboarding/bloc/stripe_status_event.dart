part of 'stripe_status_bloc.dart';

sealed class StripeStatusEvent extends Equatable {
  const StripeStatusEvent();

  @override
  List<Object> get props => [];
}

// Triggered when we want to check Stripe status
class CheckStripeStatus extends StripeStatusEvent {
  final String accountId;
  const CheckStripeStatus({required this.accountId});

  @override
  List<Object> get props => [accountId];
}

// Triggered when we request Stripe connect link
class GetStripeConnectLink extends StripeStatusEvent {}