import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecoride/helpers/request.dart';
import 'package:ecoride/resources/strings.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import '../models/reverse_geocode.dart';

class HelperMethods {
  static Future<ReverseGeocode?> findCoordsAddress(Position position) async {
    ReverseGeocode? address;

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi) {
      return address;
    }

    var queryParams = {
      'lat': position.latitude.toString(),
      'lon': position.longitude.toString(),
      'format': 'json',
      'key': dotenv.get('PLACE_API_KEY')
    };
    var response = await Request.getRequest(dotenv.get('PLACE_API'), dotenv.get('PLACE_API_REVERSE'), queryParams);
    if (response != Strings.requestFailed) {
      address = ReverseGeocode.fromJson(response);
    }

    return address;
  }
}
