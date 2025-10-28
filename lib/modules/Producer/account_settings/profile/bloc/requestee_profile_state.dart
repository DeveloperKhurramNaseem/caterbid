part of 'requestee_profile_bloc.dart';

abstract class RequesteeProfileState extends Equatable {
  const RequesteeProfileState();
  @override
  List<Object?> get props => [];
}

class RequesteeProfileInitial extends RequesteeProfileState {}
class RequesteeProfileLoading extends RequesteeProfileState {}
class RequesteeProfileLoaded extends RequesteeProfileState {
  final RequesteeModel user;
  const RequesteeProfileLoaded(this.user);
}
class RequesteeProfileUpdating extends RequesteeProfileState {}
class RequesteeProfileError extends RequesteeProfileState {
  final String message;
  const RequesteeProfileError(this.message);
}

class RequesteeProfileLoadingKeepOld extends RequesteeProfileState {
  final RequesteeModel user;
  const RequesteeProfileLoadingKeepOld(this.user);
}

class RequesteeProfileUpdatingKeepOld extends RequesteeProfileState {
  final RequesteeModel user;
  const RequesteeProfileUpdatingKeepOld(this.user);
}
class RequesteeProfileValid extends RequesteeProfileState {
  final bool isValid;
  const RequesteeProfileValid(this.isValid);

  @override
  List<Object?> get props => [isValid];
}

class RequesteeProfileSaving extends RequesteeProfileState {}
