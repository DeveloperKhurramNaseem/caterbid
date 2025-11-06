// formatted_my_bids_model.dart

import 'package:caterbid/core/utils/helpers/formatter/formatted_date.dart';
import 'package:caterbid/core/utils/helpers/formatter/currency_formatted.dart';
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
      final formatted = FormattedProviderBid(
        id: bid.id,
        title: bid.request.title,
        postedBy: bid.request.requesteeName,
        formattedDate: DateFormatter.format(bid.request.date),
        formattedAmount: CurrencyFormatter.format(bid.request.budgetDollars),
        formattedPeople: bid.request.numPeople,
        formattedLocation: bid.request.address ?? "Unknown location", 
        description: bid.description ?? "No description provided",
        myBidAmount: CurrencyFormatter.format(bid.amountDollars),
        status: bid.status,
      );

      formattedList.add(formatted);
    }

    return formattedList;
  }
}
