import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecoride/helpers/request.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import '../models/address.dart';

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
}
