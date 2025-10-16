import 'package:bloc/bloc.dart';
import 'package:caterbid/core/network/api_exception.dart';
import 'package:caterbid/modules/Producer/home/model/producer_request_model.dart';
import 'package:caterbid/modules/Producer/home/repository/producer_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'requests_event.dart';
part 'requests_state.dart';

class RequestsBloc extends Bloc<RequestsEvent, RequestsState> {
  final ProducerRepository repository;

  RequestsBloc(this.repository) : super(RequestsInitial()) {
    on<LoadRequests>(_onLoadRequests);
    on<RefreshMyRequests>(_onRefreshRequests);
  }

  /// Load from API on first open or app relaunch
  Future<void> _onLoadRequests(
      LoadRequests event, Emitter<RequestsState> emit) async {
    emit(RequestsLoading());
    await _fetchAndEmitRequests(emit);
  }

  /// Refresh from API manually or background
  Future<void> _onRefreshRequests(
      RefreshMyRequests event, Emitter<RequestsState> emit) async {
    final prev = state;
    if (prev is RequestsLoaded) {
      emit(RequestsRefreshing(
        activeRequests: prev.activeRequests,
        fulfilledRequests: prev.fulfilledRequests,
      ));
    }
    await _fetchAndEmitRequests(emit);
  }

  /// Helper function to fetch data from API and emit proper state
  Future<void> _fetchAndEmitRequests(Emitter<RequestsState> emit) async {
    try {
      final requests = await repository.fetchRequests();

      final activeRequests = requests
          .where((r) => r.status != 'fulfilled')
          .toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

      final fulfilledRequests = requests
          .where((r) => r.status == 'fulfilled')
          .toList()
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

      emit(RequestsLoaded(
        activeRequests: activeRequests,
        fulfilledRequests: fulfilledRequests,
      ));
    } catch (error) {
      emit(RequestsError(ApiErrorHandler.handle(error).message));
    }
  }
}
