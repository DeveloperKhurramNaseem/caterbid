import 'package:bloc/bloc.dart';
import 'package:caterbid/core/network/api_exception.dart';
import 'package:caterbid/core/utils/helpers/currency_formatted.dart';
import 'package:caterbid/core/utils/helpers/formatted_date.dart';
import 'package:caterbid/core/utils/helpers/location_formatter.dart';
import 'package:caterbid/modules/Producer/home/active_request/model/formatted_producer_request.dart';
import 'package:caterbid/modules/Producer/home/active_request/model/producer_request_model.dart';
import 'package:caterbid/modules/Producer/home/active_request/repository/producer_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'requests_event.dart';
part 'requests_state.dart';

class RequestsBloc extends Bloc<RequestsEvent, RequestsState> {
  final ProducerRepository repository;
  final Map<String, String> _addressCache = {};

  RequestsBloc(this.repository) : super(RequestsInitial()) {
    on<LoadRequests>(_onLoadRequests);
    on<RefreshMyRequests>(_onRefreshRequests);
  }

  Future<void> _onLoadRequests(
    LoadRequests event,
    Emitter<RequestsState> emit,
  ) async {
    emit(RequestsLoading());
    await _fetchAndEmitRequests(emit);
  }

  Future<void> _onRefreshRequests(
    RefreshMyRequests event,
    Emitter<RequestsState> emit,
  ) async {
    final prev = state;
    if (prev is RequestsLoaded) {
      emit(
        RequestsRefreshing(
          activeRequests: prev.activeRequests,
          fulfilledRequests: prev.fulfilledRequests,
        ),
      );
    }
    await _fetchAndEmitRequests(emit);
  }

  Future<void> _fetchAndEmitRequests(Emitter<RequestsState> emit) async {
    try {
      final requests = await repository.fetchRequests();

      final formattedRequests = <FormattedProducerRequest>[];

      for (final req in requests) {
        String formattedAddress = "Unknown location";
        if (req.location.coordinates.length >= 2) {
          final lat = req.location.coordinates[1];
          final lng = req.location.coordinates[0];
          final cacheKey = '${lat}_$lng';

          if (_addressCache.containsKey(cacheKey)) {
            formattedAddress = _addressCache[cacheKey]!;
          } else {
            formattedAddress = await LocationFormatter.getFormattedAddress(
              latitude: lat,
              longitude: lng,
            );
            _addressCache[cacheKey] = formattedAddress;
          }
        }

        formattedRequests.add(
          FormattedProducerRequest(
            id: req.id,
            title: req.title,
            formattedBudget: CurrencyFormatter.format(req.budgetDollars),
            formattedDate: DateFormatter.format(req.date),
            formattedTime: DateFormatter.onlyTime(req.date),
            formattedPeople: '${req.numPeople} people',
            formattedLocation: formattedAddress,
            status: req.status,
            rawDate: req.date,
            requestee: req.requestee,
          ),
        );
      }

      // Define active & fulfilled categories
      const activeStatuses = ['open', 'awarded', 'delivered'];
      const fulfilledStatuses = ['fulfilled', 'cancelled'];

      final activeRequests =
          formattedRequests
              .where((r) => activeStatuses.contains(r.status.toLowerCase()))
              .toList()
            ..sort((a, b) => b.rawDate.compareTo(a.rawDate));

      final fulfilledRequests =
          formattedRequests
              .where((r) => fulfilledStatuses.contains(r.status.toLowerCase()))
              .toList()
            ..sort((a, b) => b.rawDate.compareTo(a.rawDate));

      emit(
        RequestsLoaded(
          activeRequests: activeRequests,
          fulfilledRequests: fulfilledRequests,
        ),
      );
    } catch (error) {
      emit(RequestsError(ApiErrorHandler.handle(error).message));
    }
  }
}
