import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecoride/helpers/request.dart';
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
      'latitude': position.latitude.toString(),
      'longitude': position.longitude.toString(),
      'localityLanguage': 'es'
    };
    var response = await Request.getRequest('api.bigdatacloud.net', '/data/reverse-geocode-client', queryParams);
    if (response != 'Request failed') {
      address = ReverseGeocode.fromJson(response);
    }

    return address;
  }
}
