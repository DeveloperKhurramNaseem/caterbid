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
    FetchProducerRequests event,
    Emitter<ProducerHomeState> emit,
  ) async {
    // Show shimmer in both cases
    emit(ProducerHomeLoading());

    // If this is after creation, skip showing empty state temporarily
    await _fetchAndEmitRequests(emit, skipEmptyState: event.afterCreation);
  }

  Future<void> _onRefreshRequests(
    RefreshProducerRequests event,
    Emitter<ProducerHomeState> emit,
  ) async {
    await _fetchAndEmitRequests(emit);
  }

  /// Shared logic for fetching and emitting requests
  Future<void> _fetchAndEmitRequests(
    Emitter<ProducerHomeState> emit, {
    bool skipEmptyState = false,
  }) async {
    try {
      final requests = await repository.fetchRequests();

      if (requests.isEmpty) {
        // Don’t show empty immediately after creation
        if (!skipEmptyState) emit(ProducerHomeEmpty());
      } else {
        final sortedRequests = List<ProducerRequest>.from(requests)
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

        emit(ProducerHomeLoaded(sortedRequests));
      }
    } catch (error) {
      emit(ProducerHomeError(ApiErrorHandler.handle(error).message));
    }
  }
}
