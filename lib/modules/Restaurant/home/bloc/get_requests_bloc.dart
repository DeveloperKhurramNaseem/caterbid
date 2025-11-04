import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:caterbid/core/utils/helpers/location_formatter.dart';
import 'package:equatable/equatable.dart';
import 'package:caterbid/core/network/api_exception.dart';
import 'package:caterbid/core/utils/helpers/currency_formatted.dart';
import 'package:caterbid/core/utils/helpers/formatted_date.dart';
import 'package:caterbid/modules/Restaurant/home/model/requests_model.dart';
import 'package:caterbid/modules/Restaurant/home/model/formatted_request_model.dart';
import 'package:caterbid/modules/Restaurant/home/repository/get_resquest_list.dart';
import 'package:path/path.dart';

part 'get_requests_event.dart';
part 'get_requests_state.dart';

class GetRequestsBloc extends Bloc<GetRequestsEvent, GetRequestsState> {
  final ProviderRequestsRepository repository;
  
  Timer? _pollTimer;

  // Cache: request ID → formatted model
  final Map<String, FormattedProviderRequest> _formattedCache = {};
  // Address cache: lat_lng → address
  final Map<String, String> _addressCache = {};

  GetRequestsBloc(this.repository) : super(GetRequestsInitial()) {
    on<StartListeningRequests>(_onStart);
    on<StopListeningRequests>(_onStop);
    on<_RefreshRequests>(_onRefresh);
    on<ClearCacheEvent>(_onClearCache);
  }

  // -----------------------------------------------------------------
  // Start → Loading → fetch → poll every 5s
  // -----------------------------------------------------------------
  Future<void> _onStart(
    StartListeningRequests event,
    Emitter<GetRequestsState> emit,
  ) async {
    emit(GetRequestsLoading());
    await _loadAndFormat(emit);
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(const Duration(seconds: 15), (_) {
      add(_RefreshRequests());
    });
  }

  // -----------------------------------------------------------------
  // Refresh → reuse cache
  // -----------------------------------------------------------------
  Future<void> _onRefresh(
    _RefreshRequests event,
    Emitter<GetRequestsState> emit,
  ) async {
    await _loadAndFormat(emit);
  }

  // -----------------------------------------------------------------
  // Core: fetch + format + cache
  // -----------------------------------------------------------------
  Future<void> _loadAndFormat(Emitter<GetRequestsState> emit) async {
    try {
      final rawList = await repository.fetchProviderRequests();

      final List<FormattedProviderRequest> formattedList = [];

      final futures = rawList.map((raw) async {
        // Return from cache if exists
        if (_formattedCache.containsKey(raw.id)) {
          return _formattedCache[raw.id]!;
        }

        // Format address (cached)
        final lat = raw.location.latitude;
        final lng = raw.location.longitude;
        final addressKey = '${lat}_${lng}';

        var address = _addressCache[addressKey];
        if (address == null) {
          print(
            "📍 lat: ${raw.location.latitude}, lng: ${raw.location.longitude}",
          );
          // FIX: swap arguments
          address = await LocationFormatter.getFormattedAddress(latitude: lat, longitude:lng);
          _addressCache[addressKey] = address;
        }

        // Format all UI strings
        final formatted = FormattedProviderRequest(
          id: raw.id,
          location: raw.location,
          requestee: raw.requestee,
          title: raw.title,
          description: raw.description,
          formattedPrice: CurrencyFormatter.format(raw.budgetDollars),
          formattedDate: DateFormatter.onlyDate(raw.date),
          formattedTime: DateFormatter.onlyTime(raw.date),
          formattedPeople: '${raw.numPeople} people',
          formattedLocation: address,
          rawDate: raw.date,
          numPeople: raw.numPeople,
          status: raw.status,
          createdAt: raw.createdAt,
          currency: raw.currency,
        );

        _formattedCache[raw.id] = formatted;
        return formatted;
      });

      final results = await Future.wait(futures);
      formattedList.addAll(results);

      if (formattedList.isEmpty) {
        emit(GetRequestsEmpty());
      } else {
        emit(GetRequestsSuccess(formattedList));
      }
    } on ApiException catch (e) {
      emit(GetRequestsFailure(e.message));
    } catch (e) {
      emit(GetRequestsFailure(e.toString()));
    }
  }

  // -----------------------------------------------------------------
  // Stop polling
  // -----------------------------------------------------------------
  Future<void> _onStop(
    StopListeningRequests event,
    Emitter<GetRequestsState> emit,
  ) async {
    _pollTimer?.cancel();
    _pollTimer = null;
    emit(GetRequestsStopped());
  }

  // -----------------------------------------------------------------
  // Clear cache (e.g., logout)
  // -----------------------------------------------------------------
  void _onClearCache(ClearCacheEvent event, Emitter emit) {
    _formattedCache.clear();
    _addressCache.clear();
  }

  @override
  Future<void> close() {
    _pollTimer?.cancel();
    return super.close();
  }
}
