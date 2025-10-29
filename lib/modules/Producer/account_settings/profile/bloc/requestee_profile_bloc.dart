import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:caterbid/modules/Producer/account_settings/profile/model/requestee_profile_model.dart';
import 'package:caterbid/modules/Producer/account_settings/profile/model/update_requestee_model.dart';
import 'package:caterbid/modules/Producer/account_settings/profile/repository/requestee_profile_repository.dart';

part 'requestee_profile_event.dart';
part 'requestee_profile_state.dart';

class RequesteeProfileBloc
    extends Bloc<RequesteeProfileEvent, RequesteeProfileState> {
  final RequesteeRepository repo;

  RequesteeProfileBloc(this.repo) : super(RequesteeProfileInitial()) {
    on<LoadRequesteeProfileEvent>(_onLoadProfile);
    on<UpdateRequesteeProfileEvent>(_onUpdateProfile);
    on<LogoutRequesteeProfileEvent>(_onLogoutProfile);
    on<ValidateAndSaveProfileEvent>(_onValidateAndSave);
  }
  Future<void> _onValidateAndSave(
    ValidateAndSaveProfileEvent event,
    Emitter<RequesteeProfileState> emit,
  ) async {
    // Validation logic
    if (event.firstName.isEmpty ||
        event.lastName.isEmpty ||
        event.phoneNumber.isEmpty) {
      emit(RequesteeProfileError('Please fill in all required fields.'));
      return;
    }

    final fullName = '${event.firstName} ${event.lastName}'.trim();

    add(
      UpdateRequesteeProfileEvent(
        name: fullName,
        phoneNumber: event.phoneNumber,
        profilePicture: event.profilePicture,
      ),
    );
  }

  //  Load (with cache)
  Future<void> _onLoadProfile(
    LoadRequesteeProfileEvent event,
    Emitter<RequesteeProfileState> emit,
  ) async {
    final currentState = state;
    if (currentState is RequesteeProfileLoaded) {
      emit(RequesteeProfileLoadingKeepOld(currentState.user));
    } else {
      emit(RequesteeProfileLoading());
    }

    try {
      final user = await repo.fetchProfile();
      emit(RequesteeProfileLoaded(user));
    } catch (e) {
      emit(RequesteeProfileError('Failed to load profile: $e'));
    }
  }

  //  Update profile
  Future<void> _onUpdateProfile(
    UpdateRequesteeProfileEvent event,
    Emitter<RequesteeProfileState> emit,
  ) async {
    final currentState = state;
    if (currentState is RequesteeProfileLoaded) {
      emit(RequesteeProfileUpdatingKeepOld(currentState.user));
    } else {
      emit(RequesteeProfileUpdating());
    }

    try {
      final updatedUser = await repo.updateProfile(
        UpdateRequesteeModel(
          name: event.name,
          phoneNumber: event.phoneNumber,
          file: event.profilePicture,
        ),
      );

      emit(RequesteeProfileLoaded(updatedUser));
    } catch (e) {
      emit(RequesteeProfileError('Failed to update profile: $e'));
    }
  }

  // ✅ Logout — clears cache and in-memory data
  Future<void> _onLogoutProfile(
    LogoutRequesteeProfileEvent event,
    Emitter<RequesteeProfileState> emit,
  ) async {
    await repo.clearCache();
    emit(RequesteeProfileInitial());
  }
}
