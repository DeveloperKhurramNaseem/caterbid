// import 'dart:convert';
// import 'package:caterbid/core/key/key.dart';
// import 'package:http/http.dart' as http;
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class LocationFormatter {
//   static final Map<String, String> _addressCache = {};

//   static Future<String> getFormattedAddress({
//     required double latitude,
//     required double longitude,
//   }) async {
//     final cacheKey = '${latitude}_${longitude}';
//     if (_addressCache.containsKey(cacheKey)) {
//       return _addressCache[cacheKey]!;
//     }

//     try {
//       final apiKey = TestingKey.googleAPIKey;
//       final url =
//           'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey';
//       final response = await http.get(Uri.parse(url));

//       if (response.statusCode == 200) {
//         final data = jsonDecode(response.body);

//         if (data['results'] != null && data['results'].isNotEmpty) {
//           // Filter for best address types
//           final results = List<Map<String, dynamic>>.from(data['results']);
//           String? exactAddress;

//           for (var result in results) {
//             final types = List<String>.from(result['types']);
//             if (types.contains('street_address') ||
//                 types.contains('premise') ||
//                 types.contains('subpremise') ||
//                 types.contains('route')) {
//               exactAddress = result['formatted_address'];
//               break;
//             }
//           }

//           // Fallback to first result if no precise match
//           exactAddress ??= data['results'][0]['formatted_address'];

//           _addressCache[cacheKey] = exactAddress!;
//           return exactAddress;
//         }
//       }

//       _addressCache[cacheKey] = 'Unknown location';
//       return 'Unknown location';
//     } catch (e) {
//       _addressCache[cacheKey] = 'Error fetching address';
//       return 'Error fetching address';
//     }
//   }

//   static Future<String> fromLatLng(LatLng latLng) =>
//       getFormattedAddress(latitude: latLng.latitude, longitude: latLng.longitude);
// }
