import 'package:bloc/bloc.dart';
import 'package:caterbid/core/network/api_exception.dart';
import 'package:caterbid/core/utils/helpers/formatter/currency_formatted.dart';
import 'package:caterbid/core/utils/helpers/formatter/formatted_date.dart';
import 'package:caterbid/modules/Producer/home/active_request/model/formatted_producer_request.dart';
import 'package:caterbid/modules/Producer/home/active_request/repository/producer_repository.dart';
import 'package:equatable/equatable.dart';

part 'producer_home_event.dart';
part 'producer_home_state.dart';

class ProducerHomeBloc extends Bloc<ProducerHomeEvent, ProducerHomeState> {
  final ProducerRepository repository;

  ProducerHomeBloc(this.repository) : super(ProducerHomeInitial()) {
    on<FetchProducerRequests>(_onFetchRequests);
    on<RefreshProducerRequests>(_onRefreshRequests);
  }

  Future<void> _onFetchRequests(
    FetchProducerRequests event,
    Emitter<ProducerHomeState> emit,
  ) async {
    emit(ProducerHomeLoading());
    await _fetchAndEmitLatestOpenRequest(emit, skipEmptyState: event.afterCreation);
  }

  Future<void> _onRefreshRequests(
    RefreshProducerRequests event,
    Emitter<ProducerHomeState> emit,
  ) async {
    await _fetchAndEmitLatestOpenRequest(emit);
  }

  Future<void> _fetchAndEmitLatestOpenRequest(
    Emitter<ProducerHomeState> emit, {
    bool skipEmptyState = false,
  }) async {
    try {
      final requests = await repository.fetchRequests();

      if (requests.isEmpty) {
        if (!skipEmptyState) emit(ProducerHomeEmpty());
        return;
      }

      final openRequests = requests.where((req) => req.status.toLowerCase() == 'open');

      if (openRequests.isEmpty) {
        if (!skipEmptyState) emit(ProducerHomeEmpty());
        return;
      }

      final latestOpenRequest = openRequests.first;

      final formatted = FormattedProducerRequest(
        id: latestOpenRequest.id,
        title: latestOpenRequest.title,
        formattedBudget: CurrencyFormatter.format(latestOpenRequest.budgetDollars),
        formattedDate: DateFormatter.format(latestOpenRequest.date),
        formattedTime: DateFormatter.onlyTime(latestOpenRequest.date),
        formattedPeople: '${latestOpenRequest.numPeople} people',
        formattedLocation: latestOpenRequest.address ?? "Unknown location",
        status: latestOpenRequest.status,
        rawDate: latestOpenRequest.date,
        requestee: latestOpenRequest.requestee,
      );

      emit(ProducerHomeLoaded([formatted]));
    } catch (error) {
      emit(ProducerHomeError(ApiErrorHandler.handle(error).message));
    }
  }
}
