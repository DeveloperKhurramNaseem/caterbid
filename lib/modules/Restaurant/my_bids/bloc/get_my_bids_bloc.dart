import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:caterbid/modules/Restaurant/my_bids/model/get_my_bids_model.dart';
import 'package:caterbid/modules/Restaurant/my_bids/repository/get_my_bids_repository.dart';
import 'package:equatable/equatable.dart';

part 'get_my_bids_event.dart';
part 'get_my_bids_state.dart';

class GetMyBidsBloc extends Bloc<GetMyBidsEvent, GetMyBidsState> {
  final GetMyBidsProducerRepository repository;

  GetMyBidsBloc(this.repository) : super(GetMyBidsInitial()) {
    on<FetchMyBidsEvent>(_onFetchMyBids);
    on<FilterBidsEvent>(_onFilterBids);
  }

  List<ProviderMyBidsModel> _allBids = [];

  Future<void> _onFetchMyBids(
      FetchMyBidsEvent event, Emitter<GetMyBidsState> emit) async {
    emit(GetMyBidsLoading());
    try {
      final bids = await repository.getMyBids();
      _allBids = bids;
      emit(GetMyBidsLoaded(bids: _allBids));
    } catch (error) {
      emit(GetMyBidsError(message: error.toString()));
    }
  }

  Future<void> _onFilterBids(
      FilterBidsEvent event, Emitter<GetMyBidsState> emit) async {
    if (_allBids.isEmpty) return;

    final filtered = _allBids
        .where((b) => event.isActive ? b.status == "open" : b.status == "awarded")
        .toList();

    emit(GetMyBidsLoaded(bids: filtered));
  }
}
