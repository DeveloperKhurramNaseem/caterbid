import 'package:bloc/bloc.dart';
import 'package:caterbid/modules/Restaurant/onboarding/repository/stripe_repository.dart';
import 'package:equatable/equatable.dart';

part 'stripe_status_event.dart';
part 'stripe_status_state.dart';

class StripeStatusBloc extends Bloc<StripeStatusEvent, StripeStatusState> {
  final StripeRepository repository;

  StripeStatusBloc({required this.repository}) : super(StripeStatusInitial()) {
    on<GetStripeConnectLink>(_onGetStripeConnectLink);
    on<CheckStripeStatus>(_onCheckStripeStatus);
  }

  Future<void> _onGetStripeConnectLink(
      GetStripeConnectLink event, Emitter<StripeStatusState> emit) async {
    emit(StripeStatusLoading());
    try {
      final response = await repository.getConnectLink();
      emit(StripeStatusLoaded(
        connected: false,
        connectUrl: response.url,
        accountId: response.accountId,
      ));
    } catch (e) {
      emit(StripeStatusError(message: e.toString()));
    }
  }

  Future<void> _onCheckStripeStatus(
      CheckStripeStatus event, Emitter<StripeStatusState> emit) async {
    emit(StripeStatusLoading());
    try {
      final response = await repository.checkStatus(event.accountId);
      emit(StripeStatusLoaded(
        connected: response.isConnected,
        accountId: response.accountId,
      ));
    } catch (e) {
      emit(StripeStatusError(message: e.toString()));
    }
  }
}
