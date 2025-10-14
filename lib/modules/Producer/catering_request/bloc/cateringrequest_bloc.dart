import 'package:bloc/bloc.dart';
import 'package:caterbid/modules/Producer/catering_request/model/catering_request_model.dart';
import 'package:caterbid/modules/Producer/catering_request/model/catering_response_model.dart';
import 'package:caterbid/modules/Producer/catering_request/repository/catering_repository.dart';
import 'package:meta/meta.dart';

part 'cateringrequest_event.dart';
part 'cateringrequest_state.dart';

class CateringrequestBloc extends Bloc<CateringrequestEvent, CateringrequestState> {
  final CateringRepository repository;

  CateringrequestBloc(this.repository) : super(CateringrequestInitial()) {
    on<CreateCateringRequest>(_onCreateRequest);
  }

  Future<void> _onCreateRequest(
      CreateCateringRequest event, Emitter<CateringrequestState> emit) async {
    emit(CateringLoading());
    try {
      final response = await repository.createRequest(event.model);
      emit(CateringSuccess(response));
    } catch (e) {
      emit(CateringFailure(e.toString()));
    }
  }
}