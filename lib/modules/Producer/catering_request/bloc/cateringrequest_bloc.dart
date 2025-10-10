import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'cateringrequest_event.dart';
part 'cateringrequest_state.dart';

class CateringrequestBloc extends Bloc<CateringrequestEvent, CateringrequestState> {
  CateringrequestBloc() : super(CateringrequestInitial()) {
    on<CateringrequestEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
