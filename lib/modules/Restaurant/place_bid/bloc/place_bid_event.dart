part of 'place_bid_bloc.dart';

sealed class PlaceBidEvent extends Equatable {
  const PlaceBidEvent();

  @override
  List<Object?> get props => [];
}
class SubmitPlaceBid extends PlaceBidEvent {
  final PlaceBidRequest bid;

  const SubmitPlaceBid(this.bid);

  @override
  List<Object?> get props => [bid];
}

class ResetPlaceBid extends PlaceBidEvent {}
