part of 'provider_profile_bloc.dart';

abstract class ProviderProfileState extends Equatable {
  const ProviderProfileState();

  @override
  List<Object?> get props => [];
}

class ProviderProfileInitial extends ProviderProfileState {}

class ProviderProfileLoading extends ProviderProfileState {}

class ProviderProfileLoadingKeepOld extends ProviderProfileState {
  final ProviderModel user;
  const ProviderProfileLoadingKeepOld(this.user);

  @override
  List<Object?> get props => [user];
}

class ProviderProfileLoaded extends ProviderProfileState {
  final ProviderModel user;
  const ProviderProfileLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class ProviderProfileUpdating extends ProviderProfileState {}

class ProviderProfileUpdatingKeepOld extends ProviderProfileState {
  final ProviderModel user;
  const ProviderProfileUpdatingKeepOld(this.user);

  @override
  List<Object?> get props => [user];
}

class ProviderProfileError extends ProviderProfileState {
  final String message;
  const ProviderProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
