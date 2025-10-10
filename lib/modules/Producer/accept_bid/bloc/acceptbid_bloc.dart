import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'acceptbid_event.dart';
part 'acceptbid_state.dart';

class AcceptbidBloc extends Bloc<AcceptbidEvent, AcceptbidState> {
  AcceptbidBloc() : super(AcceptbidInitial()) {
    on<AcceptbidEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
