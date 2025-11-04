part of 'acceptbid_bloc.dart';

@immutable
sealed class AcceptbidEvent {}
class AcceptBidPressed extends AcceptbidEvent {
  final String requestId;
  final String bidId;

  AcceptBidPressed({required this.requestId, required this.bidId});
}