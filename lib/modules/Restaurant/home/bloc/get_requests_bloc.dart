import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:caterbid/core/network/api_exception.dart';
import 'package:caterbid/core/widgets/location_formatter/location_formatter.dart';
import 'package:caterbid/modules/Restaurant/home/model/requests_model.dart';
import 'package:caterbid/modules/Restaurant/home/repository/get_resquest_list.dart';
import 'package:equatable/equatable.dart';

part 'get_requests_event.dart';
part 'get_requests_state.dart';

class GetRequestsBloc extends Bloc<GetRequestsEvent, GetRequestsState> {
  final ProviderRequestsRepository repository;
  StreamSubscription<List<ProviderRequest>>? _requestsSubscription;
  final Map<String, String> _addressCache = {}; // Cache for addresses

  GetRequestsBloc(this.repository) : super(GetRequestsInitial()) {
    on<StartListeningRequests>(_onStartListening);
    on<_RequestsUpdated>(_onRequestsUpdated);
    on<StopListeningRequests>(_onStopListening);
  }

  Future<void> _onStartListening(
    StartListeningRequests event,
    Emitter<GetRequestsState> emit,
  ) async {
    emit(GetRequestsLoading());

    // Cancel old listener if any
    await _requestsSubscription?.cancel();

    // Stream to fetch requests periodically (every 5 seconds)
    final requestsStream = Stream.periodic(const Duration(seconds: 5))
        .asyncMap((_) => repository.fetchProviderRequests())
        .handleError((error) {
      throw ApiErrorHandler.handle(error);
    });

    _requestsSubscription = requestsStream.listen(
      (requests) async {
        // Fetch addresses for new requests
        final updatedRequests = <ProviderRequest>[];
        for (var request in requests) {
          final cacheKey = '${request.location.latitude}_${request.location.longitude}';
          String? formattedAddress = _addressCache[cacheKey];
          
          if (formattedAddress == null) {
            formattedAddress = await LocationFormatter.getFormattedAddress(
              request.location.latitude,
              request.location.longitude,
            );
            _addressCache[cacheKey] = formattedAddress;
          }

          updatedRequests.add(ProviderRequest(
            id: request.id,
            location: request.location,
            requestee: request.requestee,
            title: request.title,
            budgetCents: request.budgetCents,
            budgetDollars: request.budgetDollars,
            currency: request.currency,
            numPeople: request.numPeople,
            date: request.date,
            status: request.status,
            createdAt: request.createdAt,
            updatedAt: request.updatedAt,
            acceptedBidId: request.acceptedBidId,
            formattedAddress: formattedAddress, // Include the address
          ));
        }

        add(_RequestsUpdated(updatedRequests));
      },
      onError: (error) =>
          emit(GetRequestsFailure(ApiErrorHandler.handle(error).message)),
    );
  }

  void _onRequestsUpdated(_RequestsUpdated event, Emitter<GetRequestsState> emit) {
    if (event.requests.isEmpty) {
      emit(GetRequestsEmpty());
    } else {
      emit(GetRequestsSuccess(event.requests));
    }
  }

  Future<void> _onStopListening(
    StopListeningRequests event,
    Emitter<GetRequestsState> emit,
  ) async {
    await _requestsSubscription?.cancel();
    _requestsSubscription = null;
    emit(GetRequestsStopped());
  }

  @override
  Future<void> close() {
    _requestsSubscription?.cancel();
    return super.close();
  }
}