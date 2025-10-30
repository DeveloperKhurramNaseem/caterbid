// import 'package:caterbid/core/utils/helpers/currency_formatted.dart';
// import 'package:caterbid/core/utils/helpers/formatted_date.dart';
// import 'package:caterbid/modules/Restaurant/home/model/requests_model.dart';

// class RequestDataFormatter {
//   static Map<String, String?> formatRequest(ProviderRequest request) {
//     return {
//       'title': request.title,
//       'postedBy': request.requestee?.name ?? 'Unknown',
//       'price': CurrencyFormatter.format(request.budgetDollars),
//       'date': DateFormatter.onlyDate(request.date),
//       'time': DateFormatter.formatExact(request.date),
//       'people': '${request.numPeople} people',
//       'location':
//           'Lat: ${request.location.latitude.toStringAsFixed(4)}, Lng: ${request.location.longitude.toStringAsFixed(4)}',
//       'specialInstruction': request.description,
//     };
//   }
// }