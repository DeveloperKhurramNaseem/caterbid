import 'package:caterbid/modules/Producer/home/active_request/model/producer_request_model.dart';

class FormattedProducerRequest {
  final String id;
  final String title;
  final String formattedBudget;
  final String formattedDate;
  final String formattedTime;
  final String formattedPeople;
  final String formattedLocation; 
  final String status;
  final DateTime rawDate;
  final Requestee requestee;

  FormattedProducerRequest({
    required this.id,
    required this.title,
    required this.formattedBudget,
    required this.formattedDate,
    required this.formattedTime,
    required this.formattedPeople,
    required this.formattedLocation,
    required this.status,
    required this.rawDate,
    required this.requestee,
  });
}
