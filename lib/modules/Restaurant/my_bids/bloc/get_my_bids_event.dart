part of 'get_my_bids_bloc.dart';

sealed class GetMyBidsEvent extends Equatable {
  const GetMyBidsEvent();

  @override
  List<Object?> get props => [];
}

class FetchMyBidsEvent extends GetMyBidsEvent{

}

class FilterBidsEvent extends GetMyBidsEvent {
  final bool isActive;
  const FilterBidsEvent({required this.isActive});

  @override
  List<Object?> get props => [isActive];
}