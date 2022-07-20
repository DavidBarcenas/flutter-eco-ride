import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/address.dart';

class AppData extends ChangeNotifier {
  late Address? pickupAddress;
  late Address? destinationAddress;
  List<LatLng> waypoints = [];

  void updatePickupAddress(Address pickup) {
    pickupAddress = pickup;
    notifyListeners();
  }

  void updateDestinationpAddress(Address destination) {
    destinationAddress = destination;
    notifyListeners();
  }

  void updateWaypoints(List<LatLng> points) {
    waypoints = points;
    notifyListeners();
  }
}
