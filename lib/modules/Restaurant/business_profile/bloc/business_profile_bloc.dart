import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:caterbid/modules/Restaurant/business_profile/model/business_profile_model.dart';
import 'package:equatable/equatable.dart';
import 'package:caterbid/core/network/api_exception.dart';
import 'package:caterbid/modules/Restaurant/business_profile/model/business_profile_request_model.dart';
import 'package:caterbid/modules/Restaurant/business_profile/repository/business_profile_repository.dart';

part 'business_profile_event.dart';
part 'business_profile_state.dart';

class BusinessProfileBloc extends Bloc<BusinessProfileEvent, BusinessProfileState> {
  final BusinessProfileRepository repository;

  BusinessProfileBloc(this.repository) : super(BusinessProfileInitial()) {
    on<SubmitBusinessProfile>(_onSubmitBusinessProfile);
  }

  Future<void> _onSubmitBusinessProfile(
    SubmitBusinessProfile event,
    Emitter<BusinessProfileState> emit,
  ) async {
    emit(BusinessProfileLoading());

    if (event.model.businessType.isEmpty ||
        event.model.companyName.isEmpty ||
        event.model.phoneNumber.isEmpty ||
        event.profilePicture == null) {
      emit(BusinessProfileFailure("Please fill all required fields"));
      return;
    }

    try {
      final response = await repository.updateBusinessProfile(
        event.model,
        profilePicture: event.profilePicture,
      );
      emit(BusinessProfileSuccess(response));
    } catch (error) {
      final apiError = ApiErrorHandler.handle(error);
      emit(BusinessProfileFailure(apiError.message));
    }
  }
}
