part of 'verify_otp_bloc.dart';

sealed class VerifyOtpEvent extends Equatable {
  const VerifyOtpEvent();

  @override
  List<Object> get props => [];
}

class VerifyOtpButtonPressed extends VerifyOtpEvent {
  final VerifyOtpRequestModel model;

  const VerifyOtpButtonPressed(this.model);

  @override
  List<Object> get props => [model];
}