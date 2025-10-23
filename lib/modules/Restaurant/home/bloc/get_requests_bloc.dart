import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:caterbid/core/network/api_exception.dart';
import 'package:caterbid/modules/Restaurant/home/model/requests_model.dart';
import 'package:caterbid/modules/Restaurant/home/repository/get_resquest_list.dart';
import 'package:equatable/equatable.dart';

part 'get_requests_event.dart';
part 'get_requests_state.dart';

class GetRequestsBloc extends Bloc<GetRequestsEvent, GetRequestsState> {
  final ProviderRequestsRepository repository;
  StreamSubscription<List<ProviderRequest>>? _requestsSubscription;

  GetRequestsBloc(this.repository) : super(GetRequestsInitial()) {
    on<StartListeningRequests>(_onStartListening);
    on<_RequestsUpdated>(_onRequestsUpdated);
    on<StopListeningRequests>(_onStopListening);
  }

  Future<void> _onStartListening(
    StartListeningRequests event,
    Emitter<GetRequestsState> emit,
  ) async {
    emit(GetRequestsLoading());

    // Cancel old listener if any
    await _requestsSubscription?.cancel();

    // Stream to fetch requests periodically (every 5 seconds)
    final requestsStream = Stream.periodic(const Duration(seconds: 5))
        .asyncMap((_) => repository.fetchProviderRequests())
        .handleError((error) {
      throw ApiErrorHandler.handle(error);
    });

    _requestsSubscription = requestsStream.listen(
      (requests) => add(_RequestsUpdated(requests)),
      onError: (error) =>
          emit(GetRequestsFailure(ApiErrorHandler.handle(error).message)),
    );
  }

  void _onRequestsUpdated(_RequestsUpdated event, Emitter<GetRequestsState> emit) {
    if (event.requests.isEmpty) {
      emit(GetRequestsEmpty());
    } else {
      emit(GetRequestsSuccess(event.requests));
    }
  }

  Future<void> _onStopListening(
    StopListeningRequests event,
    Emitter<GetRequestsState> emit,
  ) async {
    await _requestsSubscription?.cancel();
    _requestsSubscription = null;
    emit(GetRequestsStopped());
  }

  @override
  Future<void> close() {
    _requestsSubscription?.cancel();
    return super.close();
  }
}
