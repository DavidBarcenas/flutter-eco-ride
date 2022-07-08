import 'package:flutter/material.dart';
import '../models/reverse_geocode.dart';

class AppData extends ChangeNotifier {
  late ReverseGeocode pickupAddress;

  void updatePickupAddress(ReverseGeocode pickup) {
    pickupAddress = pickup;
    notifyListeners();
  }
}
