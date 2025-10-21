import 'package:caterbid/core/network/api_endpoints.dart';
import 'package:caterbid/core/network/api_service.dart';
import 'package:caterbid/core/network/api_exception.dart';
import 'package:caterbid/modules/Restaurant/business_profile/model/business_profile_request_model.dart';
import 'package:caterbid/modules/Restaurant/business_profile/model/business_profile_model.dart';


class BusinessProfileRepository {
  final ApiService _apiService = ApiService();

  Future<BusinessProfileResponse> updateBusinessProfile(BusinessProfileRequestModel model) async{
    try{
      final response = await _apiService.put(ApiEndpoints.bussinessProfileSetup, model.toJson());
      return BusinessProfileResponse.fromJson(response);

    }catch(error){
      throw ApiErrorHandler.handle(error);
    }
  }

}
