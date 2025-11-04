part of 'requests_bloc.dart';

@immutable
sealed class RequestsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RequestsInitial extends RequestsState {}

class RequestsLoading extends RequestsState {}

class RequestsLoaded extends RequestsState {
  final List<FormattedProducerRequest> activeRequests;
  final List<FormattedProducerRequest> fulfilledRequests;

  RequestsLoaded({
    required this.activeRequests,
    required this.fulfilledRequests,
  });

  @override
  List<Object?> get props => [activeRequests, fulfilledRequests];
}

class RequestsError extends RequestsState {
  final String message;
  RequestsError(this.message);

  @override
  List<Object?> get props => [message];
}

class RequestsRefreshing extends RequestsLoaded {
  RequestsRefreshing({
    required super.activeRequests,
    required super.fulfilledRequests,
  });
}
