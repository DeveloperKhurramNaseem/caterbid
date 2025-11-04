import 'dart:async';
import 'dart:math';
import 'package:caterbid/core/utils/helpers/location_formatter.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'package:geolocator/geolocator.dart';
import 'package:overlay_loader_with_app_icon/overlay_loader_with_app_icon.dart';
import 'package:caterbid/core/config/app_colors.dart';
import 'package:caterbid/core/key/key.dart';
import 'package:go_router/go_router.dart';

class ReusableMapPicker extends StatefulWidget {
  static const path = "/map";
  const ReusableMapPicker({super.key});

  @override
  State<ReusableMapPicker> createState() => _ReusableMapPickerState();
}

class _ReusableMapPickerState extends State<ReusableMapPicker> {
  final Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _searchController = TextEditingController();

  LatLng? _selectedLatLng;
  String _selectedAddress = '';
  bool _loading = true;

  static const double radiusInMeters = 48280.3; // 30 miles

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<void> _initializeLocation() async {
    setState(() => _loading = true);
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        await Geolocator.openLocationSettings();
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied ||
            permission == LocationPermission.deniedForever)
          return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      _selectedLatLng = LatLng(position.latitude, position.longitude);
      await _updateAddressFromLatLng(_selectedLatLng!);

      // Zoom **closely** to current location
      final controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newLatLngZoom(_selectedLatLng!, 17));
    } catch (_) {
      // Handle errors silently
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _updateAddressFromLatLng(LatLng latLng) async {
    setState(() => _loading = true);

    try {
      final address = await LocationFormatter.fromLatLng(latLng);
      setState(() => _selectedAddress = address);
    } catch (_) {
      setState(() => _selectedAddress = 'Error fetching address');
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _onMapTap(LatLng tappedPoint) async {
    setState(() => _selectedLatLng = tappedPoint);
    await _updateAddressFromLatLng(tappedPoint);

    // Zoom **closely** to tapped location
    final controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLngZoom(tappedPoint, 17));
  }

  Future<void> _locateMe() async {
    setState(() => _loading = true);
    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final currentLatLng = LatLng(position.latitude, position.longitude);

      setState(() {
        _selectedLatLng = currentLatLng;
      });

      await _updateAddressFromLatLng(currentLatLng);

      final controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newLatLngZoom(currentLatLng, 17));
    } catch (e) {
      debugPrint("Error getting current location: $e");
    } finally {
      setState(() => _loading = false);
    }
  }

  // Optional: keep circle fitting function if you want to display radius
  Future<void> _fitCircleInView(LatLng center, double radius) async {
    final controller = await _controller.future;

    final southWest = LatLng(
      center.latitude - _metersToLatitude(radius),
      center.longitude - _metersToLongitude(radius, center.latitude),
    );
    final northEast = LatLng(
      center.latitude + _metersToLatitude(radius),
      center.longitude + _metersToLongitude(radius, center.latitude),
    );

    final bounds = LatLngBounds(southwest: southWest, northeast: northEast);
    controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50));
  }

  double _metersToLatitude(double meters) => meters / 111320;
  double _metersToLongitude(double meters, double latitude) =>
      meters / (111320 * cos(latitude * pi / 180));

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top + 15;
    final sidePadding = 15.0;

    return OverlayLoaderWithAppIcon(
      isLoading: _loading,
      appIcon: Image.asset('assets/icons/app_icon.png', width: 80, height: 80),
      circularProgressColor: AppColors.c500,
      overlayBackgroundColor: Colors.black.withOpacity(0.4),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: _selectedLatLng == null
            ? const SizedBox.shrink()
            : Stack(
                children: [
                  // Google Map
                  GoogleMap(
                    onMapCreated: (controller) {
                      if (!_controller.isCompleted) {
                        _controller.complete(controller);
                      }
                    },
                    initialCameraPosition: CameraPosition(
                      target: _selectedLatLng!,
                      zoom: 17, // zoomed in
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId('selected'),
                        position: _selectedLatLng!,
                      ),
                    },
                    circles: {
                      Circle(
                        circleId: const CircleId('radius'),
                        center: _selectedLatLng!,
                        radius: radiusInMeters,
                        fillColor: const Color(0x66D5F8F8),
                        strokeColor: const Color(0xFFD5F8F8),
                        strokeWidth: 3,
                      ),
                    },
                    onTap: _onMapTap,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: false,
                  ),

                  // Back button
                  Positioned(
                    top: topPadding,
                    left: sidePadding,
                    child: FloatingActionButton(
                      heroTag: 'back_button',
                      onPressed: () => context.pop(),
                      backgroundColor: const Color(0xFFD5F8F8),
                      foregroundColor: Colors.black,
                      mini: true,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: const Icon(Icons.arrow_back),
                    ),
                  ),

                  // Search bar
                  Positioned(
                    top: topPadding,
                    left: sidePadding + 55,
                    right: sidePadding,
                    child: Material(
                      color: const Color(0xFFD5F8F8),
                      elevation: 1,
                      borderRadius: BorderRadius.circular(18),
                      child: GooglePlaceAutoCompleteTextField(
                        textEditingController: _searchController,
                        googleAPIKey: TestingKey.googleAPIKey,
                        inputDecoration: const InputDecoration(
                          hintText: "Search location...",
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                        debounceTime: 400,
                        getPlaceDetailWithLatLng: (Prediction prediction) async {
                          final lat = double.tryParse(prediction.lat ?? "");
                          final lng = double.tryParse(prediction.lng ?? "");
                          if (lat != null && lng != null) {
                            final pos = LatLng(lat, lng);
                            setState(() {
                              _selectedLatLng = pos;
                              _selectedAddress = prediction.description ?? '';
                            });

                            final controller = await _controller.future;
                            controller.animateCamera(CameraUpdate.newLatLngZoom(pos, 17));
                          }
                        },
                        itemClick: (Prediction prediction) {
                          _searchController.text = prediction.description ?? '';
                        },
                      ),
                    ),
                  ),

                  // Locate Me button
                  Positioned(
                    bottom: 200,
                    right: 20,
                    child: FloatingActionButton(
                      heroTag: 'locate_me',
                      onPressed: _locateMe,
                      backgroundColor: const Color(0xFFD5F8F8),
                      foregroundColor: Colors.black,
                      child: const Icon(Icons.gps_fixed),
                    ),
                  ),

                  // Address display
                  if (_selectedAddress.isNotEmpty)
                    Positioned(
                      bottom: 100,
                      left: 20,
                      right: 20,
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(color: Colors.black26, blurRadius: 5),
                          ],
                        ),
                        child: Text(
                          _selectedAddress,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ),

                  // Confirm button
                  Positioned(
                    bottom: 30,
                    left: 20,
                    right: 20,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16),
                        backgroundColor: AppColors.c500,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      onPressed: () {
                        if (_selectedLatLng != null) {
                          context.pop({
                            'address': _selectedAddress,
                            'lat': _selectedLatLng!.latitude,
                            'lng': _selectedLatLng!.longitude,
                          });
                        }
                      },
                      child: const Text(
                        "Confirm Location",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
