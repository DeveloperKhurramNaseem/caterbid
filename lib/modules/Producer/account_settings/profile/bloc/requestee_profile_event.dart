part of 'requestee_profile_bloc.dart';

abstract class RequesteeProfileEvent extends Equatable {
  const RequesteeProfileEvent();
  @override
  List<Object?> get props => [];
}

class LoadRequesteeProfileEvent extends RequesteeProfileEvent {}
class RefreshRequesteeProfileEvent extends RequesteeProfileEvent {}
class UpdateRequesteeProfileEvent extends RequesteeProfileEvent {
  final String name;
  final String phoneNumber;
  final File? profilePicture;
  const UpdateRequesteeProfileEvent({required this.name, required this.phoneNumber, this.profilePicture});
}

class ValidateAndSaveProfileEvent extends RequesteeProfileEvent {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final File? profilePicture;

  const ValidateAndSaveProfileEvent({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.profilePicture,
  });
}


class LogoutRequesteeProfileEvent extends RequesteeProfileEvent {}

