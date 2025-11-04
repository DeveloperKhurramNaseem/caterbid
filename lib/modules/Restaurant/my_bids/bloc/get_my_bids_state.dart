part of 'get_my_bids_bloc.dart';

abstract class GetMyBidsState extends Equatable {
  const GetMyBidsState();
  @override
  List<Object?> get props => [];
}

class GetMyBidsInitial extends GetMyBidsState {}

class GetMyBidsLoading extends GetMyBidsState {}

class GetMyBidsLoaded extends GetMyBidsState {
  final List<FormattedProviderBid> bids;
  const GetMyBidsLoaded({required this.bids});

  @override
  List<Object?> get props => [bids];
}

class GetMyBidsError extends GetMyBidsState {
  final String message;
  const GetMyBidsError({required this.message});

  @override
  List<Object?> get props => [message];
}
