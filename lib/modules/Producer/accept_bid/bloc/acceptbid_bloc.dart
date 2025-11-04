import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../repository/accept_bid_repository.dart';

part 'acceptbid_event.dart';
part 'acceptbid_state.dart';

class AcceptbidBloc extends Bloc<AcceptbidEvent, AcceptbidState> {
  final AcceptBidRepository repository;

  AcceptbidBloc(this.repository) : super(AcceptbidInitial()) {
    on<AcceptBidPressed>((event, emit) async {
      emit(AcceptBidLoading());
      try {
        final response = await repository.acceptBid(
          requestId: event.requestId,
          bidId: event.bidId,
        );
        emit(AcceptBidSuccess(response: response));
      } catch (e) {
        emit(AcceptBidFailure(error: e.toString()));
      }
    });
  }
}
