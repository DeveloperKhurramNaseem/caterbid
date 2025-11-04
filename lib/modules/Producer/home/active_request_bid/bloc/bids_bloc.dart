import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:caterbid/core/network/api_exception.dart';
import 'package:caterbid/core/utils/helpers/location_formatter.dart';
import 'package:caterbid/modules/Producer/home/active_request_bid/model/formatted_bid_model.dart';
import 'package:caterbid/modules/Producer/home/active_request_bid/model/producer_bid_model.dart';
import 'package:caterbid/modules/Producer/home/active_request_bid/repository/producer_bid_repository.dart';
import 'package:equatable/equatable.dart';

part 'bids_event.dart';
part 'bids_state.dart';

class BidsBloc extends Bloc<BidsEvent, BidsState> {
  final BidsRepository repository;
  final Map<String, String> _addressCache =
      {}; // Cache for reverse geocoded addresses

  StreamSubscription<List<BidModel>>? _bidsSubscription;

  BidsBloc(this.repository) : super(BidsInitial()) {
    on<StartListeningBids>(_onStartListening);
    on<_BidsUpdated>(_onBidsUpdated);
    on<_BidsFailed>(_onBidsFailed);
    on<StopListeningBids>(_onStopListening);
  }

  Future<void> _onStartListening(
    StartListeningBids event,
    Emitter<BidsState> emit,
  ) async {
    emit(BidsLoading());

    await _bidsSubscription?.cancel();

    final bidsStream = Stream.periodic(const Duration(seconds: 15)).asyncMap((
      _,
    ) async {
      try {
        return await repository.fetchBidsByRequestId(event.requestId);
      } catch (error) {
        throw ApiErrorHandler.handle(error);
      }
    });

    _bidsSubscription = bidsStream.listen(
      (bids) => add(_BidsUpdated(bids)),
      onError: (error) =>
          add(_BidsFailed(ApiErrorHandler.handle(error).message)),
    );
  }

  Future<void> _onBidsUpdated(
    _BidsUpdated event,
    Emitter<BidsState> emit,
  ) async {
    if (event.bids.isEmpty) {
      emit(BidsEmpty());
      return;
    }

    final List<FormattedBidModel> formattedBids = [];

    for (var bid in event.bids) {
      String formattedAddress = "Unknown location";

      if (bid.request.location != null &&
          bid.request.location!.coordinates.length >= 2) {
        final lat = bid.request.location!.coordinates[1];
        final lng = bid.request.location!.coordinates[0];
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

      formattedBids.add(FormattedBidModel.fromBid(bid, formattedAddress));
    }

    emit(BidsLoaded(formattedBids));
  }

  void _onBidsFailed(_BidsFailed event, Emitter<BidsState> emit) {
    emit(BidsError(event.message));
  }

  Future<void> _onStopListening(
    StopListeningBids event,
    Emitter<BidsState> emit,
  ) async {
    await _bidsSubscription?.cancel();
    _bidsSubscription = null;
    emit(BidsStopped());
  }

  @override
  Future<void> close() {
    _bidsSubscription?.cancel();
    return super.close();
  }
}
