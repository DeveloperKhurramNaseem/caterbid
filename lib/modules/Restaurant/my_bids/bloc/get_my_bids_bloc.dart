import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:caterbid/modules/Restaurant/my_bids/model/get_my_bids_model.dart';
import 'package:caterbid/modules/Restaurant/my_bids/repository/get_my_bids_repository.dart';
import 'package:caterbid/modules/Restaurant/my_bids/model/formatted_my_bids_model.dart';

part 'get_my_bids_event.dart';
part 'get_my_bids_state.dart';

class GetMyBidsBloc extends Bloc<GetMyBidsEvent, GetMyBidsState> {
  final GetMyBidsProducerRepository repository;

  GetMyBidsBloc(this.repository) : super(GetMyBidsInitial()) {
    on<FetchMyBidsEvent>(_onFetchMyBids);
    on<FilterBidsEvent>(_onFilterBids);
    on<RefreshMyBidsEvent>(_onRefreshMyBids); // <-- new handler
  }

  List<ProviderMyBidsModel> _allBids = [];

  Future<void> _onFetchMyBids(
    FetchMyBidsEvent event,
    Emitter<GetMyBidsState> emit,
  ) async {
    emit(GetMyBidsLoading());
    try {
      final bids = await repository.getMyBids();
      _allBids = bids;

      final formatted = await MyBidsFormatter.formatList(bids);

      emit(GetMyBidsLoaded(bids: formatted));
    } catch (error) {
      emit(GetMyBidsError(message: error.toString()));
    }
  }

  Future<void> _onFilterBids(
    FilterBidsEvent event,
    Emitter<GetMyBidsState> emit,
  ) async {
    if (_allBids.isEmpty) return;

    final activeStatuses = [
      "proposed",
      "accepted_pending_checkout",
      "rejected",
      "paid",
      "delivered_pending_transfer",
    ];

    final fulfilledStatuses = ["transferred"];

    final filtered = _allBids.where((b) {
      return event.isActive
          ? activeStatuses.contains(b.status)
          : fulfilledStatuses.contains(b.status);
    }).toList();

    final formatted = await MyBidsFormatter.formatList(filtered);

    emit(GetMyBidsLoaded(bids: formatted));
  }

  Future<void> _onRefreshMyBids(
    RefreshMyBidsEvent event,
    Emitter<GetMyBidsState> emit,
  ) => _onFetchMyBids(FetchMyBidsEvent(), emit);
}
