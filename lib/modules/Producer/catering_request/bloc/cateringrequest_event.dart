part of 'cateringrequest_bloc.dart';

@immutable
sealed class CateringrequestEvent {}

class CreateCateringRequest extends CateringrequestEvent {
  final CateringRequestModel model;
  CreateCateringRequest(this.model);
}