part of 'requests_bloc.dart';

@immutable
sealed class RequestsEvent {}
class LoadRequests extends RequestsEvent {}

class RefreshMyRequests extends RequestsEvent {}

