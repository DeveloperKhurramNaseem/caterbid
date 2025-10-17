import 'package:bloc/bloc.dart';
import 'package:caterbid/core/network/api_exception.dart';
import 'package:caterbid/modules/auth/forget_Password/Change_password_request/model/change_password_request.dart';
import 'package:caterbid/modules/auth/forget_Password/Change_password_request/repository/change_password_request_repository.dart';
import 'package:equatable/equatable.dart';

part 'change_password_request_event.dart';
part 'change_password_request_state.dart';

class ChangePasswordRequestBloc extends Bloc<ChangePasswordRequestEvent, ChangePasswordRequestState> {

  final ChangePasswordRepository repository;

  ChangePasswordRequestBloc(this.repository) : super(ChangePasswordRequestInitial()) {
    on<ChangePasswordRequestEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<SubmitChangePassword>(_onSubmitChangePassword);

  }

    Future<void> _onSubmitChangePassword(
    SubmitChangePassword event,
    Emitter<ChangePasswordRequestState> emit,
  ) async {
    emit(ChangePasswordLoading());
    try {
      await repository.changepassword(event.request);
      emit(ChangePasswordSuccess());
    } catch (error) {
      final apiError = ApiErrorHandler.handle(error);
      emit(ChangePasswordFailure(apiError.message));
    }
  }
}
