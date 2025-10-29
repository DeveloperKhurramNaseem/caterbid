part of 'provider_profile_bloc.dart';

abstract class ProviderProfileState extends Equatable {
  const ProviderProfileState();
  @override
  List<Object?> get props => [];
}

class ProviderProfileInitial extends ProviderProfileState {}
class ProviderProfileLoading extends ProviderProfileState {}
class ProviderProfileLoaded extends ProviderProfileState {
  final ProviderModel user;
  const ProviderProfileLoaded(this.user);
  @override
  List<Object?> get props => [user];
}

class ProviderProfileUpdating extends ProviderProfileState {}
class ProviderProfileError extends ProviderProfileState {
  final String message;
  const ProviderProfileError(this.message);
  @override
  List<Object?> get props => [message];
}

class ProviderProfileLoadingKeepOld extends ProviderProfileState {
  final ProviderModel user;
  const ProviderProfileLoadingKeepOld(this.user);
  @override
  List<Object?> get props => [user];
}

class ProviderProfileUpdatingKeepOld extends ProviderProfileState {
  final ProviderModel user;
  const ProviderProfileUpdatingKeepOld(this.user);
  @override
  List<Object?> get props => [user];
}

class ProviderProfileValid extends ProviderProfileState {
  final bool isValid;
  const ProviderProfileValid(this.isValid);
  @override
  List<Object?> get props => [isValid];
}

class ProviderProfileSaving extends ProviderProfileState {}