import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'business_profile_event.dart';
part 'business_profile_state.dart';

class BusinessProfileBloc extends Bloc<BusinessProfileEvent, BusinessProfileState> {
  BusinessProfileBloc() : super(BusinessProfileInitial()) {
    on<BusinessProfileEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
