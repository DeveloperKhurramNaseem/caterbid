// class CateringResponseModel {
//   final String id;
//   final String title;
//   final int budgetCents;
//   final int budgetDollars;
//   final String currency;
//   final int numPeople;
//   final DateTime date;
//   final String status;

//   CateringResponseModel({
//     required this.id,
//     required this.title,
//     required this.budgetCents,
//     required this.budgetDollars,
//     required this.currency,
//     required this.numPeople,
//     required this.date,
//     required this.status,
//   });

//   factory CateringResponseModel.fromJson(Map<String, dynamic> json) {
//     return CateringResponseModel(
//       id: json['_id'],
//       title: json['title'],
//       budgetCents: json['budgetCents'],
//       budgetDollars: json['budgetDollars'],
//       currency: json['currency'],
//       numPeople: json['numPeople'],
//       date: DateTime.parse(json['date']),
//       status: json['status'],
//     );
//   }
// }
