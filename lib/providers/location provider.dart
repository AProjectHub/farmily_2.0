import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationProvider with ChangeNotifier {
  Position? _currentPosition;

  Future<void> getCurrentLocation() async {
    try {
      _currentPosition = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } catch (e) {
      print(e);
    }
    notifyListeners();
  }
  Position? get currentPosition => _currentPosition;
}
