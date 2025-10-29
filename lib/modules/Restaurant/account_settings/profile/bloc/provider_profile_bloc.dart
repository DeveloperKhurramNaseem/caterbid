import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:caterbid/modules/Restaurant/account_settings/profile/model/provider_profile_model.dart';
import 'package:caterbid/modules/Restaurant/account_settings/profile/model/update_provider_model.dart';
import 'package:caterbid/modules/Restaurant/account_settings/profile/repository/provider_profile_repository.dart';
import 'package:equatable/equatable.dart';

part 'provider_profile_event.dart';
part 'provider_profile_state.dart';

class ProviderProfileBloc extends Bloc<ProviderProfileEvent, ProviderProfileState> {
  final ProviderRepository repo;

  ProviderProfileBloc(this.repo) : super(ProviderProfileInitial()) {
    on<LoadProviderProfileEvent>(_onLoadProfile);
    on<UpdateProviderProfileEvent>(_onUpdateProfile);
    on<LogoutProviderProfileEvent>(_onLogoutProfile);
    on<ValidateAndSaveProfileEvent>(_onValidateAndSave);
  }

  Future<void> _onValidateAndSave(
    ValidateAndSaveProfileEvent event,
    Emitter<ProviderProfileState> emit,
  ) async {
    if (event.companyName.isEmpty ||
        event.businessType.isEmpty ||
        event.phoneNumber.isEmpty) {
      emit(ProviderProfileError('Please fill in all required fields.'));
      return;
    }

    add(
      UpdateProviderProfileEvent(
        name: event.name,
        companyName: event.companyName,
        businessType: event.businessType,
        description: event.description,
        phoneNumber: event.phoneNumber,
        lat: event.lat,
        lng: event.lng,
        profilePicture: event.profilePicture,
      ),
    );
  }

  Future<void> _onLoadProfile(
    LoadProviderProfileEvent event,
    Emitter<ProviderProfileState> emit,
  ) async {
    final currentState = state;
    if (currentState is ProviderProfileLoaded) {
      emit(ProviderProfileLoadingKeepOld(currentState.user));
    } else {
      emit(ProviderProfileLoading());
    }

    try {
      final user = await repo.fetchProfile();
      emit(ProviderProfileLoaded(user));
    } catch (e) {
      emit(ProviderProfileError('Failed to load profile: $e'));
    }
  }

  Future<void> _onUpdateProfile(
    UpdateProviderProfileEvent event,
    Emitter<ProviderProfileState> emit,
  ) async {
    final currentState = state;
    if (currentState is ProviderProfileLoaded) {
      emit(ProviderProfileUpdatingKeepOld(currentState.user));
    } else {
      emit(ProviderProfileUpdating());
    }

    try {
      final updatedUser = await repo.updateProfile(
        UpdateProviderModel(
          name: event.name,
          companyName: event.companyName,
          businessType: event.businessType,
          description: event.description,
          phoneNumber: event.phoneNumber,
          lat: event.lat,
          lng: event.lng,
          file: event.profilePicture,
        ),
      );

      emit(ProviderProfileLoaded(updatedUser));
    } catch (e) {
      emit(ProviderProfileError('Failed to update profile: $e'));
    }
  }

  Future<void> _onLogoutProfile(
    LogoutProviderProfileEvent event,
    Emitter<ProviderProfileState> emit,
  ) async {
    await repo.clearCache();
    emit(ProviderProfileInitial());
  }
}