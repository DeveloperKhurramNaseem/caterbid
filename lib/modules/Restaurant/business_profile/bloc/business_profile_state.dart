part of 'business_profile_bloc.dart';

sealed class BusinessProfileState extends Equatable {
  const BusinessProfileState();
  
  @override
  List<Object> get props => [];
}

final class BusinessProfileInitial extends BusinessProfileState {}
