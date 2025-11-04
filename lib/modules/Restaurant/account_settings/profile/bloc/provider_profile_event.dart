part of 'provider_profile_bloc.dart';

abstract class ProviderProfileEvent extends Equatable {
  const ProviderProfileEvent();
  @override
  List<Object?> get props => [];
}

class LoadProviderProfileEvent extends ProviderProfileEvent {}
class RefreshProviderProfileEvent extends ProviderProfileEvent {}

class UpdateProviderProfileEvent extends ProviderProfileEvent {
  final String name;
  final String companyName;
  final String businessType;
  final String description;
  final String phoneNumber;
  final double lat;
  final double lng;
  final File? profilePicture;

  const UpdateProviderProfileEvent({
    required this.name,
    required this.companyName,
    required this.businessType,
    required this.description,
    required this.phoneNumber,
    required this.lat,
    required this.lng,
    this.profilePicture,
  });

  @override
  List<Object?> get props => [
        name,
        companyName,
        businessType,
        description,
        phoneNumber,
        lat,
        lng,
        profilePicture,
      ];
}

class ValidateAndSaveProfileEvent extends ProviderProfileEvent {
  final String name;
  final String companyName;
  final String businessType;
  final String description;
  final String phoneNumber;
  final double lat;
  final double lng;
  final File? profilePicture;

  const ValidateAndSaveProfileEvent({
    required this.name,
    required this.companyName,
    required this.businessType,
    required this.description,
    required this.phoneNumber,
    required this.lat,
    required this.lng,
    this.profilePicture,
  });

  @override
  List<Object?> get props => [
        name,
        companyName,
        businessType,
        description,
        phoneNumber,
        lat,
        lng,
        profilePicture,
      ];
}

class UpdateLocationEvent extends ProviderProfileEvent {
  final double lat;
  final double lng;
  const UpdateLocationEvent(this.lat, this.lng);
}

class LogoutProviderProfileEvent extends ProviderProfileEvent {}