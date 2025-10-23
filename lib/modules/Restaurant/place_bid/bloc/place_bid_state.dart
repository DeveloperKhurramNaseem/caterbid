part of 'place_bid_bloc.dart';

sealed class PlaceBidState extends Equatable {
  const PlaceBidState();
  
  @override
  List<Object> get props => [];
}

class PlaceBidInitial extends PlaceBidState {}
class PlaceBidLoading extends PlaceBidState {}
class PlaceBidSuccess extends PlaceBidState {}
class PlaceBidFailure extends PlaceBidState {
  final String error;
  const PlaceBidFailure(this.error);

  @override
  List<Object> get props => [error];
}