import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:caterbid/modules/Restaurant/place_bid/model/place_bid_formdata_model.dart';
import 'package:caterbid/modules/Restaurant/place_bid/repository/place_bid_repository.dart';
import 'package:equatable/equatable.dart';

part 'place_bid_event.dart';
part 'place_bid_state.dart';

class PlaceBidBloc extends Bloc<PlaceBidEvent, PlaceBidState> {
  final PlaceBidRepository repository;

  PlaceBidBloc(this.repository) : super(PlaceBidInitial()) {
    on<PlaceBidEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<SubmitPlaceBid>(_SubmitPlaceBid);
    on<ResetPlaceBid>((event, emit) => emit(PlaceBidInitial()));
  }

  Future<void> _SubmitPlaceBid(
    SubmitPlaceBid event,
    Emitter<PlaceBidState> emit,
  ) async {
    emit(PlaceBidLoading());
    try {
      await repository.placeBid(event.bid);
      emit(PlaceBidSuccess());
    } catch (e) {
      emit(PlaceBidFailure(e.toString()));
    }
  }
}
