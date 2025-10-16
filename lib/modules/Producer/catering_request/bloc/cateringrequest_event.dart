part of 'cateringrequest_bloc.dart';

sealed class CateringrequestEvent {}

class CreateCateringRequest extends CateringrequestEvent {
  final CateringRequestModel requestModel;
  CreateCateringRequest(this.requestModel);
}

