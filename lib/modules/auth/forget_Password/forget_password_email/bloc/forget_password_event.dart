part of 'forget_password_bloc.dart';

sealed class ForgetPasswordEvent extends Equatable {
  const ForgetPasswordEvent();

  @override
  List<Object> get props => [];
}

class SubmitForgetPasswordEmail extends ForgetPasswordEvent {
  final ForgetPasswordRequest model;

  const SubmitForgetPasswordEmail(this.model);

  @override
  List<Object> get props => [model];
}
