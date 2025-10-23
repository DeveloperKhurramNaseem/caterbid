part of 'producer_home_bloc.dart';

sealed class ProducerHomeEvent extends Equatable {
  const ProducerHomeEvent();

  @override
  List<Object> get props => [];
}
class FetchProducerRequests extends ProducerHomeEvent {
  final bool afterCreation;
  const FetchProducerRequests({this.afterCreation = false});

  @override
  List<Object> get props => [afterCreation];
}

class RefreshProducerRequests extends ProducerHomeEvent {}

class ReloadAfterCreation extends ProducerHomeEvent {}