part of 'business_profile_bloc.dart';

sealed class BusinessProfileEvent extends Equatable {
  const BusinessProfileEvent();

  @override
  List<Object> get props => [];
}

class SubmitBusinessProfile extends BusinessProfileEvent {
  final BusinessProfileRequestModel model;
  const SubmitBusinessProfile(this.model);
}
