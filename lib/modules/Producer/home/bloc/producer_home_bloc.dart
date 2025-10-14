import 'package:bloc/bloc.dart';
import 'package:caterbid/core/network/api_exception.dart';
import 'package:caterbid/modules/Producer/home/model/producer_request_model.dart';
import 'package:caterbid/modules/Producer/home/repository/producer_repository.dart';
import 'package:equatable/equatable.dart';

part 'producer_home_event.dart';
part 'producer_home_state.dart';

class ProducerHomeBloc extends Bloc<ProducerHomeEvent, ProducerHomeState> {
  final ProducerRepository repository;

  ProducerHomeBloc(this.repository) : super(ProducerHomeInitial()) {
    on<FetchProducerRequests>(_onFetchRequests);
    on<RefreshProducerRequests>(_onRefreshRequests);
  }

  Future<void> _onFetchRequests(
      FetchProducerRequests event, Emitter<ProducerHomeState> emit) async {
    emit(ProducerHomeLoading());
    try {
      final requests = await repository.fetchRequests();
      if (requests.isEmpty) {
        emit(ProducerHomeEmpty());
      } else {
        emit(ProducerHomeLoaded(requests));
      }
    } catch (error) {
      emit(ProducerHomeError(ApiErrorHandler.handle(error).message));
    }
  }

  Future<void> _onRefreshRequests(
      RefreshProducerRequests event, Emitter<ProducerHomeState> emit) async {
    try {
      final requests = await repository.fetchRequests();
      if (requests.isEmpty) {
        emit(ProducerHomeEmpty());
      } else {
        emit(ProducerHomeLoaded(requests));
      }
    } catch (error) {
      emit(ProducerHomeError(ApiErrorHandler.handle(error).message));
    }
  }
}