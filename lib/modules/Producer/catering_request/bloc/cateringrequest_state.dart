part of 'cateringrequest_bloc.dart';

@immutable
sealed class CateringrequestState {}

final class CateringrequestInitial extends CateringrequestState {}

class CateringLoading extends CateringrequestState {}

class CateringSuccess extends CateringrequestState {
  final CateringResponseModel response;
  CateringSuccess(this.response);
}

class CateringFailure extends CateringrequestState {
  final String message;
  CateringFailure(this.message);
}