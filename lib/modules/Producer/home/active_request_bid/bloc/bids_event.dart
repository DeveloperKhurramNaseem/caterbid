part of 'bids_bloc.dart';

sealed class BidsEvent extends Equatable {
  const BidsEvent();

  @override
  List<Object?> get props => [];
}

class StartListeningBids extends BidsEvent {
  final String requestId;

  const StartListeningBids(this.requestId);

  @override
  List<Object?> get props => [requestId];
}

class _BidsUpdated extends BidsEvent {
  final List<BidModel> bids;

  const _BidsUpdated(this.bids);

  @override
  List<Object?> get props => [bids];
}

class StopListeningBids extends BidsEvent {}
