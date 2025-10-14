import 'package:bloc/bloc.dart';
import 'package:caterbid/core/network/api_exception.dart';
import 'package:caterbid/modules/auth/verify_email_screen/model/verify_otp_request.dart';
import 'package:caterbid/modules/auth/verify_email_screen/repository/verify_otp_repository.dart';
import 'package:equatable/equatable.dart';

part 'verify_otp_event.dart';
part 'verify_otp_state.dart';

class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  final VerifyOtpRepository repository;

  VerifyOtpBloc(this.repository) : super(VerifyOtpInitial()) {
    on<VerifyOtpButtonPressed>(_onVerifyOtp);
  }

  Future<void> _onVerifyOtp(
    VerifyOtpButtonPressed event,
    Emitter<VerifyOtpState> emit,
  ) async {
    emit(VerifyOtpLoading());
    try {
      final response = await repository.verifyOtp(event.model);
      emit(VerifyOtpSuccess(response));
    } catch (error) {
      final apiError = ApiErrorHandler.handle(error);
      emit(VerifyOtpFailure(apiError.message));
    }
  }
}