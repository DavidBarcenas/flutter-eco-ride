import 'package:flutter/material.dart';
import '../models/address.dart';

class AppData extends ChangeNotifier {
  late Address pickupAddress;

  void updatePickupAddress(Address pickup) {
    pickupAddress = pickup;
    notifyListeners();
  }
}
