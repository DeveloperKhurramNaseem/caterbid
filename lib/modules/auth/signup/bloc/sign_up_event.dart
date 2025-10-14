part of 'sign_up_bloc.dart';

@immutable
sealed class SignUpEvent {  const SignUpEvent();

  @override
  List<Object?> get props => [];
}

class SignUpButtonPressed extends SignUpEvent {
  final SignUpRequestModel model;

  const SignUpButtonPressed(this.model);

  @override
  List<Object?> get props => [model];
}
