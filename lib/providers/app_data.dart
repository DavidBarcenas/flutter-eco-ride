import 'package:flutter/material.dart';
import '../models/address.dart';

class AppData extends ChangeNotifier {
  late Address pickupAddress;
  late Address destinationAddress;

  void updatePickupAddress(Address pickup) {
    pickupAddress = pickup;
    notifyListeners();
  }

  void updateDestinationpAddress(Address destination) {
    destinationAddress = destination;
    notifyListeners();
  }
}
