part of 'get_my_bids_bloc.dart';

sealed class GetMyBidsState extends Equatable {
  const GetMyBidsState();
  
  @override
  List<Object> get props => [];
}

final class GetMyBidsInitial extends GetMyBidsState {}
