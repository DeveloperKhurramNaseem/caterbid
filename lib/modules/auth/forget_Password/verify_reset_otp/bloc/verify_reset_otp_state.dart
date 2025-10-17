part of 'verify_reset_otp_bloc.dart';

sealed class VerifyResetOtpState extends Equatable {
  const VerifyResetOtpState();
  
  @override
  List<Object> get props => [];
}

final class VerifyResetOtpInitial extends VerifyResetOtpState {}

final class VerifyOtpLoading extends VerifyResetOtpState {}

final class VerifyOtpSuccess extends VerifyResetOtpState {
  final String email;
  const VerifyOtpSuccess(this.email);

  @override
  List<Object> get props => [email];
}

final class VerifyOtpFailure extends VerifyResetOtpState {
  final String message;
  const VerifyOtpFailure(this.message);

  @override
  List<Object> get props => [message];
}