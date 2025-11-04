part of 'bids_bloc.dart';

sealed class BidsState extends Equatable {
  const BidsState();
  
  @override
  List<Object?> get props => [];
}

final class BidsInitial extends BidsState {}
class BidsLoading extends BidsState {}

class BidsLoaded extends BidsState {
  final List<FormattedBidModel> bids;

  const BidsLoaded(this.bids);

  @override
  List<Object?> get props => [bids];
}

class BidsEmpty extends BidsState {}

class BidsError extends BidsState {
  final String message;

  const BidsError(this.message);

  @override
  List<Object?> get props => [message];
}

class BidsStopped extends BidsState {}