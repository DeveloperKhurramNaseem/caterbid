import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:caterbid/core/network/api_exception.dart';
import 'package:caterbid/modules/Restaurant/business_profile/model/business_profile_model.dart';
import 'package:caterbid/modules/Restaurant/business_profile/model/business_profile_request_model.dart';
import 'package:caterbid/modules/Restaurant/business_profile/repository/business_profile_repository.dart';
import 'package:equatable/equatable.dart';

part 'business_profile_event.dart';
part 'business_profile_state.dart';

class BusinessProfileBloc extends Bloc<BusinessProfileEvent, BusinessProfileState> {

  final BusinessProfileRepository repository;

  BusinessProfileBloc(this.repository) : super(BusinessProfileInitial()) {
    on<BusinessProfileEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<SubmitBusinessProfile>(_onSubmitBusinessProfile);
  }

  FutureOr<void> _onSubmitBusinessProfile(SubmitBusinessProfile event, Emitter<BusinessProfileState> emit) async {
  emit(BusinessProfileLoading());
  try{
    final response = await repository.updateBusinessProfile(event.model);
        emit(BusinessProfileSuccess(response));

  }catch (error) {
      final apiError = ApiErrorHandler.handle(error);
      emit(BusinessProfileFailure(apiError.message));
  }
}
}