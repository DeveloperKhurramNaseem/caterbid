part of 'verify_reset_otp_bloc.dart';

sealed class VerifyResetOtpEvent extends Equatable {
  const VerifyResetOtpEvent();

  @override
  List<Object> get props => [];
}

class SubmitOtpEvent extends VerifyResetOtpEvent {
  final VerifyOtpRequest request;

  const SubmitOtpEvent(this.request);

  @override
  List<Object> get props => [request];
}