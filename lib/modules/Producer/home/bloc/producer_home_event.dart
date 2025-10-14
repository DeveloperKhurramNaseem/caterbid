part of 'producer_home_bloc.dart';

sealed class ProducerHomeEvent extends Equatable {
  const ProducerHomeEvent();

  @override
  List<Object> get props => [];
}
class FetchProducerRequests extends ProducerHomeEvent {}

class RefreshProducerRequests extends ProducerHomeEvent {}
