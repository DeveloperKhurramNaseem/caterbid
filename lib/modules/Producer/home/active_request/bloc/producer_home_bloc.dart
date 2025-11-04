import 'package:bloc/bloc.dart';
import 'package:caterbid/core/network/api_exception.dart';
import 'package:caterbid/core/utils/helpers/currency_formatted.dart';
import 'package:caterbid/core/utils/helpers/formatted_date.dart';
import 'package:caterbid/core/utils/helpers/location_formatter.dart';
import 'package:caterbid/modules/Producer/home/active_request/model/formatted_producer_request.dart';
import 'package:caterbid/modules/Producer/home/active_request/model/producer_request_model.dart';
import 'package:caterbid/modules/Producer/home/active_request/repository/producer_repository.dart';
import 'package:equatable/equatable.dart';

part 'producer_home_event.dart';
part 'producer_home_state.dart';

class ProducerHomeBloc extends Bloc<ProducerHomeEvent, ProducerHomeState> {
  final ProducerRepository repository;
  final Map<String, String> _addressCache = {};

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

      // Find first open request
      final latestOpenRequest = requests.firstWhere(
        (req) => req.status.toLowerCase() == 'open',
        orElse: () => ProducerRequest.empty(),
      );

      if (latestOpenRequest.id.isEmpty) {
        emit(ProducerHomeEmpty());
        return;
      }

      // --- Format address (cached) ---
      String formattedAddress = "Unknown location";
      if (latestOpenRequest.location.coordinates.length >= 2) {
        final lat = latestOpenRequest.location.coordinates[1];
        final lng = latestOpenRequest.location.coordinates[0];
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

      // --- Build formatted model for UI ---
      final formatted = FormattedProducerRequest(
        id: latestOpenRequest.id,
        title: latestOpenRequest.title,
        formattedBudget: CurrencyFormatter.format(
          latestOpenRequest.budgetDollars,
        ),
        formattedDate: DateFormatter.format(latestOpenRequest.date),
        formattedTime: DateFormatter.onlyTime(latestOpenRequest.date),
        formattedPeople: '${latestOpenRequest.numPeople} people',
        formattedLocation: formattedAddress,
        status: latestOpenRequest.status,
        rawDate: latestOpenRequest.date,
        requestee: latestOpenRequest.requestee,
      );

      emit(ProducerHomeLoaded([formatted]));
    } catch (error) {
      emit(ProducerHomeError(ApiErrorHandler.handle(error).message));
    }
  }
}
