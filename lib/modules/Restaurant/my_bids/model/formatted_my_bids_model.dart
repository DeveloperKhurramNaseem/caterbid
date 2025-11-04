// formatted_my_bids_model.dart

import 'package:caterbid/core/utils/helpers/location_formatter.dart';
import 'package:caterbid/core/utils/helpers/formatted_date.dart';
import 'package:caterbid/core/utils/helpers/currency_formatted.dart';
import 'package:caterbid/modules/Restaurant/my_bids/model/get_my_bids_model.dart';

class FormattedProviderBid {
  final String id;
  final String title;
  final String postedBy;
  final String formattedDate;
  final String formattedAmount;
  final int formattedPeople;
  final String formattedLocation;
  final String description;
  final String myBidAmount;
  final String status;

  FormattedProviderBid({
    required this.id,
    required this.title,
    required this.postedBy,
    required this.formattedDate,
    required this.formattedAmount,
    required this.formattedPeople,
    required this.formattedLocation,
    required this.description,
    required this.myBidAmount,
    required this.status,
  });
}

class MyBidsFormatter {
  static Future<List<FormattedProviderBid>> formatList(
    List<ProviderMyBidsModel> bids,
  ) async {
    final List<FormattedProviderBid> formattedList = [];

    for (final bid in bids) {
      // Get coordinates (lat, lng)
      final lat = bid.request.location.coordinates.length > 1
          ? bid.request.location.coordinates[1]
          : 0.0;
      final lng = bid.request.location.coordinates.isNotEmpty
          ? bid.request.location.coordinates[0]
          : 0.0;

      // Get formatted address
      final address = await LocationFormatter.getFormattedAddress(
        latitude: lat,
        longitude: lng,
      );

      final formatted = FormattedProviderBid(
        id: bid.id,
        title: bid.request.title,
        postedBy: "Unknown", // TODO: will come from API later
        formattedDate: DateFormatter.format(bid.request.date),
        formattedAmount: CurrencyFormatter.format(bid.amountDollars),
        formattedPeople: bid.request.numPeople,
        formattedLocation: address,
        description: bid.description ?? "No description provided",
        myBidAmount: "--", // TODO: waiting for API
        status: bid.status,
      );

      formattedList.add(formatted);
    }

    return formattedList;
  }
}
