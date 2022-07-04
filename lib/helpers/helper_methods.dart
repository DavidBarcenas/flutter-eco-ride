import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecoride/helpers/request.dart';
import 'package:geolocator/geolocator.dart';

class HelperMethods {
  static Future<String> findCoordsAddress(Position position) async {
    String placeAddress = '';

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.mobile && connectivityResult != ConnectivityResult.wifi) {
      return placeAddress;
    }

    var queryParams = {
      'latitude': position.latitude.toString(),
      'longitude': position.longitude.toString(),
      'localityLanguage': 'es'
    };
    var response = await Request.getRequest('api.bigdatacloud.net', '/data/reverse-geocode-client', queryParams);
    if (response != 'Request failed') {
      placeAddress = response['locality'];
    }

    return placeAddress;
  }
}
