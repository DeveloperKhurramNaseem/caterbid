// verify_otp_state.dart
part of 'verify_otp_bloc.dart';

sealed class VerifyOtpState extends Equatable {
  const VerifyOtpState();

  @override
  List<Object> get props => [];
}

final class VerifyOtpInitial extends VerifyOtpState {}

final class VerifyOtpLoading extends VerifyOtpState {}


final class VerifyOtpSuccess extends VerifyOtpState {
  final VerifyOtpResponseModel user; 

  const VerifyOtpSuccess(this.user);

  @override
  List<Object> get props => [user];
}

final class VerifyOtpFailure extends VerifyOtpState {
  final String error;

  const VerifyOtpFailure(this.error);

  @override
  List<Object> get props => [error];
}

// Resend OTP states
class ResendOtpLoading extends VerifyOtpState {}
class ResendOtpSuccess extends VerifyOtpState {
  final String message;
  const ResendOtpSuccess(this.message);
}
class ResendOtpFailure extends VerifyOtpState {
  final String error;
  const ResendOtpFailure(this.error);
}