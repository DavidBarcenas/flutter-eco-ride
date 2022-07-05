import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:ecoride/helpers/request.dart';
import 'package:ecoride/providers/app_data.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../models/address.dart';

class HelperMethods {
  static Future<String> findCoordsAddress(Position position, BuildContext context) async {
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
      Address pickupAddress = new Address(
          placeName: placeName,
          latitud: latitud,
          longitude: longitude,
          placeId: placeId,
          placeFormattedAddress: placeFormattedAddress);

      Provider.of<AppData>(context, listen: false).updatePickupAddress(pickupAddress);
    }

    return placeAddress;
  }
}
