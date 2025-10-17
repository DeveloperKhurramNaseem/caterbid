import 'package:bloc/bloc.dart';
import 'package:caterbid/core/network/api_exception.dart';
import 'package:caterbid/modules/auth/forget_Password/verify_reset_otp/model/verify_otp_request.dart';
import 'package:caterbid/modules/auth/forget_Password/verify_reset_otp/repository/verify_otp_repository.dart';
import 'package:equatable/equatable.dart';

part 'verify_reset_otp_event.dart';
part 'verify_reset_otp_state.dart';

class VerifyResetOtpBloc extends Bloc<VerifyResetOtpEvent, VerifyResetOtpState> {
  final VerifyOtpRepository verifyOtpRepository;

  VerifyResetOtpBloc(this.verifyOtpRepository) : super(VerifyResetOtpInitial()) {
    on<VerifyResetOtpEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<SubmitOtpEvent>(_onSubmitOtp);

  }

  Future<void> _onSubmitOtp(
    SubmitOtpEvent event,
    Emitter<VerifyResetOtpState> emit,
  ) async {
    emit(VerifyOtpLoading());
    try {
      final response = await verifyOtpRepository.verifyOtp(event.request);
      emit(VerifyOtpSuccess(event.request.email));
    } catch (error) {
      final apiError = ApiErrorHandler.handle(error);
      emit(VerifyOtpFailure(apiError.message));
    }
  }
}