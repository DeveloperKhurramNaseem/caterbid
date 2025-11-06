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
class SearchRequestsEvent extends GetRequestsEvent {
  final String keyword;
  const SearchRequestsEvent(this.keyword);
}

class SortRequestsEvent extends GetRequestsEvent {
  final String sortBy; // "oldest" or "latest"
  const SortRequestsEvent(this.sortBy);
}


class ClearCacheEvent extends GetRequestsEvent {}
