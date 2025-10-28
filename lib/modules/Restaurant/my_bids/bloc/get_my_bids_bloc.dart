import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'get_my_bids_event.dart';
part 'get_my_bids_state.dart';

class GetMyBidsBloc extends Bloc<GetMyBidsEvent, GetMyBidsState> {
  GetMyBidsBloc() : super(GetMyBidsInitial()) {
    on<GetMyBidsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
