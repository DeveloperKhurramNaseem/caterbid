import 'package:bloc/bloc.dart';
import 'package:caterbid/core/network/api_exception.dart';
import 'package:caterbid/modules/Producer/home/active_request/model/producer_request_model.dart';
import 'package:caterbid/modules/Producer/home/active_request/repository/producer_repository.dart';
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
    FetchProducerRequests event,
    Emitter<ProducerHomeState> emit,
  ) async {
    emit(ProducerHomeLoading());
    await _fetchAndEmitLatestOpenRequest(
      emit,
      skipEmptyState: event.afterCreation,
    );
  }

  Future<void> _onRefreshRequests(
    RefreshProducerRequests event,
    Emitter<ProducerHomeState> emit,
  ) async {
    await _fetchAndEmitLatestOpenRequest(emit);
  }

  /// Fetches all requests and emits the latest one with status == "open"
  Future<void> _fetchAndEmitLatestOpenRequest(
    Emitter<ProducerHomeState> emit, {
    bool skipEmptyState = false,
  }) async {
    try {
      final requests = await repository.fetchRequests();

      if (requests.isEmpty) {
        if (!skipEmptyState) emit(ProducerHomeEmpty());
        return;
      }

      // Find the first request with "open" status
      final latestOpenRequest = requests.firstWhere(
        (req) => req.status.toLowerCase() == 'open',
        orElse: () => ProducerRequest(
          id: '',
          title: '',
          budgetCents: 0,
          budgetDollars: 0,
          currency: '',
          numPeople: 0,
          status: '',
          date: DateTime.now(),
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          requestee: Requestee(id: '', name: ''),
          location: Location(type: '', coordinates: []),
        ),
      );

      if (latestOpenRequest.id.isEmpty) {
        // No open requests found
        emit(ProducerHomeEmpty());
        return;
      }

      emit(ProducerHomeLoaded([latestOpenRequest]));
    } catch (error) {
      emit(ProducerHomeError(ApiErrorHandler.handle(error).message));
    }
  }
}
