import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecoride/helpers/request.dart';
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
      'latitude': position.latitude.toString(),
      'longitude': position.longitude.toString(),
      'localityLanguage': 'es'
    };
    var response = await Request.getRequest('api.bigdatacloud.net', '/data/reverse-geocode-client', queryParams);
    if (response != 'Request failed') {
      address = Address(
          placeName: response['locality'],
          latitud: response['locality'],
          longitude: response['locality'],
          placeId: response['locality'],
          placeFormattedAddress: response['locality']);
    }

    return address;
  }
}
