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
  final Map<String, dynamic> response;

  const VerifyOtpSuccess(this.response);

  @override
  List<Object> get props => [response];
}

final class VerifyOtpFailure extends VerifyOtpState {
  final String error;

  const VerifyOtpFailure(this.error);

  @override
  List<Object> get props => [error];
}
