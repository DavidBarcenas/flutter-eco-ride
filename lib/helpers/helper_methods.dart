import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecoride/helpers/request.dart';
import 'package:ecoride/resources/strings.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/address.dart';
import '../models/direction_details.dart';

class HelperMethods {
  static Future<Address?> findCoordsAddress(Position position) async {
    Address? address;

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi) {
      return address;
    }
    var url = '${dotenv.get('PLACE_API')}${dotenv.get('PLACE_API_REVERSE')}';
    var params =
        '?lat=${position.latitude}&lon=${position.longitude}&format=json&apiKey=${dotenv.get('PLACE_API_KEY')}';
    var response = await Request.getRequest('$url$params');
    if (response == Strings.requestFailed) {
      return null;
    }
    address = Address.fromJson(response['results'][0]);

    return address;
  }

  static Future<DirectionDetails?> getDirectionDetails(LatLng startPosition, LatLng endPosition) async {
    var startCoords = '${startPosition.latitude},${startPosition.longitude}';
    var endCoords = '${endPosition.latitude},${endPosition.longitude}';
    var url = '${dotenv.get('PLACE_API')}${dotenv.get('PLACE_API_ROUTING')}';
    var params = '?waypoints=$startCoords|$endCoords&mode=drive&apiKey=${dotenv.get('PLACE_API_KEY')}';
    var response = await Request.getRequest('$url$params');

    if (response == Strings.requestFailed) {
      return null;
    }
    return DirectionDetails.fromJson(response);
  }

  static Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error(Strings.locationDisabled);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error(Strings.locationPermissionDenied);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(Strings.locationCannotRequest);
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
}
