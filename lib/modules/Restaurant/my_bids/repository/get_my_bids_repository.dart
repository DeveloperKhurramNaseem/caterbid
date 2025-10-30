import 'package:caterbid/core/network/api_endpoints.dart';
import 'package:caterbid/core/network/api_exception.dart';
import 'package:caterbid/core/network/api_service.dart';
import 'package:caterbid/modules/Restaurant/my_bids/model/get_my_bids_model.dart';

class GetMyBidsProducerRepository{
  final ApiService _apiService;

  GetMyBidsProducerRepository({required ApiService apiService}) : _apiService = apiService;

  Future<List<ProviderMyBidsModel>> getMyBids() async{
    try{
      final response = await _apiService.get(ApiEndpoints.getMybids);

      if (response is List){
        return response.map((item) => ProviderMyBidsModel.fromJson(item)).toList();
      }else{
        throw ApiException(message: 'Unexpected response format: expected a list');
      }
    }catch(e){
      throw ApiErrorHandler.handle(e);
    }
  }

}