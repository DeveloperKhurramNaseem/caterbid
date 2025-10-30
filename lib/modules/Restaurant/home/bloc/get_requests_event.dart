part of 'get_requests_bloc.dart';

sealed class GetRequestsEvent extends Equatable {
  const GetRequestsEvent();

  @override
  List<Object?> get props => [];
}



class StartListeningRequests extends GetRequestsEvent {}

class _RequestsUpdated extends GetRequestsEvent {
  final List<ProviderRequest> requests;
  const _RequestsUpdated(this.requests);

  @override
  List<Object?> get props => [requests];
}

class StopListeningRequests extends GetRequestsEvent {}

class _RefreshRequests extends GetRequestsEvent{

}

class ClearCacheEvent extends GetRequestsEvent {}