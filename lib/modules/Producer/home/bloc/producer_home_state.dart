part of 'producer_home_bloc.dart';

sealed class ProducerHomeState extends Equatable {
  const ProducerHomeState();
  
  @override
  List<Object> get props => [];
}


class ProducerHomeInitial extends ProducerHomeState {}

class ProducerHomeLoading extends ProducerHomeState {}

class ProducerHomeLoaded extends ProducerHomeState {
  final List<ProducerRequest> requests;
  const ProducerHomeLoaded(this.requests);

  @override
  List<Object> get props => [requests];
}

class ProducerHomeEmpty extends ProducerHomeState {}

class ProducerHomeError extends ProducerHomeState {
  final String message;
  const ProducerHomeError(this.message);

  @override
  List<Object> get props => [message];
}