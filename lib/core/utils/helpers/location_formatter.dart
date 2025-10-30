import 'package:geocoding/geocoding.dart';

class LocationFormatter {
  // Cache to store previously fetched addresses
  static final Map<String, String> _addressCache = {};

  /// Converts latitude and longitude to a human-readable address.
  /// Returns a formatted address string or a fallback message if the address cannot be resolved.
  static Future<String> getFormattedAddress(double latitude, double longitude) async {
    final cacheKey = '${latitude}_${longitude}';
    
    // Return cached address if available
    if (_addressCache.containsKey(cacheKey)) {
      return _addressCache[cacheKey]!;
    }

    try {
      // Perform reverse geocoding
      List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isEmpty) {
        _addressCache[cacheKey] = 'Unknown location';
        return 'Unknown location';
      }

      // Extract relevant address components
      Placemark placemark = placemarks[0];
      String address = [
        placemark.street,
        placemark.locality,
        placemark.administrativeArea,
        placemark.country,
      ].where((element) => element != null && element.isNotEmpty).join(', ');

      final result = address.isNotEmpty ? address : 'Unknown location';
      _addressCache[cacheKey] = result; // Cache the result
      return result;
    } catch (e) {
      _addressCache[cacheKey] = 'Error fetching address';
      return 'Error fetching address';
    }
  }
}