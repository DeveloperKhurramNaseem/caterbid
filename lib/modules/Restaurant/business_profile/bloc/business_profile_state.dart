part of 'business_profile_bloc.dart';

sealed class BusinessProfileState extends Equatable {
  const BusinessProfileState();

  @override
  List<Object?> get props => [];
}

final class BusinessProfileInitial extends BusinessProfileState {}

final class BusinessProfileLoading extends BusinessProfileState {}

final class BusinessProfileSuccess extends BusinessProfileState {
  final BusinessProfileResponse response; 
  const BusinessProfileSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

final class BusinessProfileFailure extends BusinessProfileState {
  final String error;
  const BusinessProfileFailure(this.error);

  @override
  List<Object?> get props => [error];
}
