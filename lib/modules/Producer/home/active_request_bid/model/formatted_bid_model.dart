import 'package:caterbid/modules/Producer/home/active_request_bid/model/producer_bid_model.dart';

class FormattedBidModel {
  final String id; // bid id
  final String requestId;
  final String title;
  final String providerName;
  final String providerCompany;
  final String? providerProfileUrl;
  final int amountCents;
  final int amountDollars;
  final String currency;
  final String description;
  final String? attachmentUrl;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String formattedLocation;
  final int numPeople;
  final String requesteeName;
  final DateTime date;

  FormattedBidModel({
    required this.id,
    required this.requestId,
    required this.title,
    required this.providerName,
    required this.providerCompany,
    this.providerProfileUrl,
    required this.amountCents,
    required this.amountDollars,
    required this.currency,
    required this.description,
    this.attachmentUrl,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.formattedLocation,
    required this.numPeople,
    required this.requesteeName,
    required this.date,
  });

  factory FormattedBidModel.fromBid(BidModel bid) {
    return FormattedBidModel(
      id: bid.id,
      requestId: bid.request.id,
      title: bid.request.title,
      date: bid.request.date,
      providerName: bid.provider.name,
      providerCompany: bid.provider.companyName,
      providerProfileUrl: bid.providerProfileUrl,
      amountCents: bid.amountCents,
      amountDollars: bid.amountDollars,
      currency: bid.currency,
      description: bid.description,
      attachmentUrl: bid.attachmentUrl,
      status: bid.status,
      createdAt: bid.createdAt,
      updatedAt: bid.updatedAt,
      formattedLocation: bid.request.address ?? "Unknown location",
      numPeople: bid.request.numPeople,
      requesteeName: bid.request.requestee?.name ?? '',
    );
  }
}
