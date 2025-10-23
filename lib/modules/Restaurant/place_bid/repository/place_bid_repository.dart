import 'dart:io';

import 'package:caterbid/core/network/api_endpoints.dart';
import 'package:caterbid/core/network/api_service.dart';
import 'package:caterbid/modules/Restaurant/place_bid/model/place_bid_formdata_model.dart';

class PlaceBidRepository {
  final ApiService _apiService = ApiService();

  Future<dynamic> placeBid(PlaceBidRequest bid) async {

    return await _apiService.postMultipart(
      ApiEndpoints.placeBid,
      fields: bid.toFields(),
      file: bid.attachment,
      fileFieldName: "attachment", 
    );
  }
}
