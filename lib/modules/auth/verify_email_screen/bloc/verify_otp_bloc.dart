import 'package:bloc/bloc.dart';
import 'package:caterbid/core/network/api_exception.dart';
import 'package:caterbid/core/utils/helpers/secure_storage.dart';
import 'package:caterbid/core/utils/prefs/shared_preferences.dart';
import 'package:caterbid/modules/auth/verify_email_screen/model/verify_otp_request.dart';
import 'package:caterbid/modules/auth/verify_email_screen/model/verify_otp_response_model.dart';
import 'package:caterbid/modules/auth/verify_email_screen/repository/verify_otp_repository.dart';
import 'package:equatable/equatable.dart';

part 'verify_otp_event.dart';
part 'verify_otp_state.dart';

class VerifyOtpBloc extends Bloc<VerifyOtpEvent, VerifyOtpState> {
  final EmailVerifyOtpRepository repository;

  VerifyOtpBloc(this.repository) : super(VerifyOtpInitial()) {
    on<VerifyOtpButtonPressed>(_onVerifyOtp);
   on<ResendOtpButtonPressed>(_onResendOtp); // 👈 Add this

  }


  Future<void> _onVerifyOtp(
    VerifyOtpButtonPressed event,
    Emitter<VerifyOtpState> emit,
  ) async {
    emit(VerifyOtpLoading());
    try {
      final response = await repository.verifyOtp(event.model);

      // Save token immediately
      await SecureStorage.saveToken(response.token);

      emit(VerifyOtpSuccess(response));
    } catch (error) {
      final apiError = ApiErrorHandler.handle(error);
      emit(VerifyOtpFailure(apiError.message));
    }
  }

    Future<void> _onResendOtp(
    ResendOtpButtonPressed event,
    Emitter<VerifyOtpState> emit,
  ) async {
    emit(ResendOtpLoading());
    try {
      await repository.resendOtp(email: event.email, role: event.role);
      emit(ResendOtpSuccess("OTP has been resent successfully!"));
    } catch (error) {
      final apiError = ApiErrorHandler.handle(error);
      emit(ResendOtpFailure(apiError.message));
    }
  }
}
