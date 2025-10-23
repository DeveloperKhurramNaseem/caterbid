import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:caterbid/core/network/api_exception.dart';
import 'package:caterbid/modules/Producer/home/active_request_bid/model/producer_bid_model.dart';
import 'package:caterbid/modules/Producer/home/active_request_bid/repository/producer_bid_repository.dart';
import 'package:equatable/equatable.dart';

part 'bids_event.dart';
part 'bids_state.dart';

class BidsBloc extends Bloc<BidsEvent, BidsState> {
  final BidsRepository repository;
  StreamSubscription<List<BidModel>>? _bidsSubscription;

  BidsBloc(this.repository) : super(BidsInitial()) {
    on<StartListeningBids>(_onStartListening);
    on<_BidsUpdated>(_onBidsUpdated);
    on<StopListeningBids>(_onStopListening);
  }

  Future<void> _onStartListening(
    StartListeningBids event,
    Emitter<BidsState> emit,
  ) async {
    emit(BidsLoading());

    // Cancel old listener if exists
    await _bidsSubscription?.cancel();

    // Create periodic stream (poll every 3 seconds)
    final bidsStream = Stream.periodic(const Duration(seconds: 3))
        .asyncMap((_) => repository.fetchBidsByRequestId(event.requestId))
        .handleError((error) {
      throw ApiErrorHandler.handle(error);
    });

    _bidsSubscription = bidsStream.listen(
      (bids) => add(_BidsUpdated(bids)),
      onError: (error) => emit(BidsError(ApiErrorHandler.handle(error).message)),
    );
  }

  void _onBidsUpdated(_BidsUpdated event, Emitter<BidsState> emit) {
    if (event.bids.isEmpty) {
      emit(BidsEmpty());
    } else {
      emit(BidsLoaded(event.bids));
    }
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
