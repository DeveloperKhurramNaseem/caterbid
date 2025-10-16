import 'package:bloc/bloc.dart';
import 'package:caterbid/core/network/api_exception.dart';
import 'package:caterbid/modules/Producer/catering_request/model/catering_request_model.dart';
import 'package:caterbid/modules/Producer/catering_request/repository/catering_repository.dart';

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
    await repository.createRequest(event.requestModel);
    emit(CateringSuccess());
  } catch (error) {
    emit(CateringFailure(ApiErrorHandler.handle(error).message));
  }
  }
}