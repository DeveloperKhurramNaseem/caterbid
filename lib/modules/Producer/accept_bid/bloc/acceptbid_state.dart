part of 'acceptbid_bloc.dart';

@immutable
sealed class AcceptbidState {}

final class AcceptbidInitial extends AcceptbidState {}

class AcceptBidLoading extends AcceptbidState {}

class AcceptBidSuccess extends AcceptbidState {
  final Map<String, dynamic> response;
  AcceptBidSuccess({required this.response});
}

class AcceptBidFailure extends AcceptbidState {
  final String error;
  AcceptBidFailure({required this.error});
}