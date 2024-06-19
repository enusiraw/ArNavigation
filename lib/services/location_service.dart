// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

class LocationService with ChangeNotifier {
  Position? _currentLocation;
  bool permissionService = false;
  LocationPermission? permission;

  static String _currentAddress = "";

  static String get currentAddress => _currentAddress;

  Future<void> checkAndRequestLocation(BuildContext context) async {
    permissionService = await Geolocator.isLocationServiceEnabled();
    if (!permissionService) {
      _promptEnableLocation(context);
      return;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Location permissions are denied.");
        return;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      print("Location permissions are permanently denied.");
      return;
    }
    await _getCurrentLocation();
    await _getAddress();
  }

  Future<void> _getCurrentLocation() async {
    _currentLocation = await Geolocator.getCurrentPosition();
  }

  Future<void> _getAddress() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _currentLocation!.latitude,
        _currentLocation!.longitude,
      );

      Placemark place = placemarks[0];
      _currentAddress = "${place.locality}, ${place.country}";
      notifyListeners(); // Notify listeners when the address is updated.
    } catch (e) {
      print(e);
    }
  }

  void _promptEnableLocation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Location Required"),
          content: const Text("This app requires location services to be enabled. Please turn on location services."),
          actions: <Widget>[
            TextButton(
              child: const Text("Settings"),
              onPressed: () {
                Geolocator.openLocationSettings();
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
