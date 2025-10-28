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
    on<_BidsFailed>(_onBidsFailed);
    on<StopListeningBids>(_onStopListening);
  }

  Future<void> _onStartListening(
    StartListeningBids event,
    Emitter<BidsState> emit,
  ) async {
    emit(BidsLoading());

    await _bidsSubscription?.cancel();

    final bidsStream = Stream.periodic(const Duration(seconds: 3))
        .asyncMap((_) async {
          try {
            return await repository.fetchBidsByRequestId(event.requestId);
          } catch (error) {
            throw ApiErrorHandler.handle(error);
          }
        });

    _bidsSubscription = bidsStream.listen(
      (bids) => add(_BidsUpdated(bids)),
      onError: (error) => add(_BidsFailed(ApiErrorHandler.handle(error).message)),
    );
  }

  void _onBidsUpdated(_BidsUpdated event, Emitter<BidsState> emit) {
    if (event.bids.isEmpty) {
      emit(BidsEmpty());
    } else {
      emit(BidsLoaded(event.bids));
    }
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
