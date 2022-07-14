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

    var queryParams = {
      'lat': position.latitude.toString(),
      'lon': position.longitude.toString(),
      'format': 'json',
      'apiKey': dotenv.get('PLACE_API_KEY')
    };
    var response = await Request.getRequest(dotenv.get('PLACE_API'), dotenv.get('PLACE_API_REVERSE'), queryParams);
    if (response != response['results'].length > 0) {
      address = Address.fromJson(response['results'][0]);
    }

    return address;
  }

  static Future<DirectionDetails?> getDirectionDetails(LatLng startPosition, LatLng endPosition) async {
    var startCoords = '${startPosition.latitude}, ${startPosition.longitude}';
    var endCoords = '${startPosition.latitude}, ${startPosition.longitude}';
    var queryParams = {'waypoints': '$startCoords|$endCoords', 'mode': 'drive', 'apiKey': dotenv.get('PLACE_API_KEY')};
    var response = await Request.getRequest(dotenv.get('PLACE_API'), dotenv.get('PLACE_API_ROUTING'), queryParams);

    if (response == Strings.requestFailed) {
      return null;
    }

    return DirectionDetails.fromJson(response[0]);
  }
}
