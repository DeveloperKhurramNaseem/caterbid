import 'dart:convert';
import 'package:caterbid/core/key/key.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationFormatter {
  // Cache to store previously fetched addresses
  static final Map<String, String> _addressCache = {};

  /// Converts LatLng or coordinates to a human-readable address.
  /// Works for both map selection and backend coordinates.
  static Future<String> getFormattedAddress({
    required double latitude,
    required double longitude,
  }) async {
    final cacheKey = '${latitude}_${longitude}';

    // Return cached address if available
    if (_addressCache.containsKey(cacheKey)) {
      return _addressCache[cacheKey]!;
    }

    try {
      final apiKey = TestingKey.googleAPIKey;
      final url =
          'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=$apiKey';
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['results'] != null && data['results'].isNotEmpty) {
          final formattedAddress = data['results'][0]['formatted_address'];
          _addressCache[cacheKey] = formattedAddress;
          return formattedAddress;
        }
      }

      _addressCache[cacheKey] = 'Unknown location';
      return 'Unknown location';
    } catch (e) {
      _addressCache[cacheKey] = 'Error fetching address';
      return 'Error fetching address';
    }
  }

  /// Optional helper to convert LatLng directly
  static Future<String> fromLatLng(LatLng latLng) =>
      getFormattedAddress(latitude: latLng.latitude, longitude: latLng.longitude);
}
