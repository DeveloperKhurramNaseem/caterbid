part of 'cateringrequest_bloc.dart';

sealed class CateringrequestState {}

final class CateringrequestInitial extends CateringrequestState {}

class CateringLoading extends CateringrequestState {}

class CateringSuccess extends CateringrequestState {

}

class CateringFailure extends CateringrequestState {
  final String message;
  CateringFailure(this.message);
}