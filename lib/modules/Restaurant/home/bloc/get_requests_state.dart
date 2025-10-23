part of 'get_requests_bloc.dart';

abstract class GetRequestsState extends Equatable {
  const GetRequestsState();

  @override
  List<Object?> get props => [];
}

class GetRequestsInitial extends GetRequestsState {}

class GetRequestsLoading extends GetRequestsState {}

class GetRequestsSuccess extends GetRequestsState {
  final List<ProviderRequest> requests;
  const GetRequestsSuccess(this.requests);

  @override
  List<Object?> get props => [requests];
}

class GetRequestsEmpty extends GetRequestsState {}

class GetRequestsFailure extends GetRequestsState {
  final String error;
  const GetRequestsFailure(this.error);

  @override
  List<Object?> get props => [error];
}

class GetRequestsStopped extends GetRequestsState {}
