part of 'requests_bloc.dart';

@immutable
sealed class RequestsState extends Equatable {
    @override
  List<Object?> get props => [];
}

class RequestsInitial extends RequestsState {}

class RequestsLoading extends RequestsState {}

class RequestsLoaded extends RequestsState {
  final List<ProducerRequest> activeRequests;
  final List<ProducerRequest> fulfilledRequests;

  RequestsLoaded({
    required this.activeRequests,
    required this.fulfilledRequests,
  });
}

class RequestsError extends RequestsState {
  final String message;
  RequestsError(this.message);
}

class RequestsRefreshing extends RequestsLoaded {
  RequestsRefreshing({
    required super.activeRequests,
    required super.fulfilledRequests,
  });
}

