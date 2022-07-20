import 'dart:async';
import 'dart:io';

import 'package:ecoride/models/address.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../helpers/helper_methods.dart';
import '../providers/app_data.dart';

class GMap extends StatefulWidget {
  const GMap({Key? key}) : super(key: key);

  @override
  State<GMap> createState() => _GMapState();
}

class _GMapState extends State<GMap> {
  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? mapController;
  double mapBottomPadding = 0;
  late List<LatLng> polylineCoords;
  final Set<Polyline> _polylines = {};

  static const CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    polylineCoords = Provider.of<AppData>(context, listen: true).waypoints;
    var pickup = Provider.of<AppData>(context, listen: false).pickupAddress;
    var destination = Provider.of<AppData>(context, listen: false).destinationAddress;
    _polylines.clear;

    setState(() {
      Polyline polyline = Polyline(
          polylineId: const PolylineId("polylineId"),
          color: const Color.fromARGB(255, 95, 109, 237),
          points: polylineCoords,
          jointType: JointType.round,
          width: 4,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
          geodesic: true);
      _polylines.add(polyline);
    });

    LatLngBounds bounds;
    if (pickup!.latitud > destination!.latitud && pickup.longitude > destination.longitude) {
      bounds = LatLngBounds(
          southwest: LatLng(destination.latitud, destination.longitude),
          northeast: LatLng(pickup.latitud, pickup.longitude));
    } else if (pickup.longitude > destination.longitude) {
      bounds = LatLngBounds(
          southwest: LatLng(pickup.latitud, destination.longitude),
          northeast: LatLng(destination.latitud, pickup.longitude));
    } else if (pickup.latitud > destination.latitud) {
      bounds = LatLngBounds(
          southwest: LatLng(destination.latitud, pickup.longitude),
          northeast: LatLng(pickup.latitud, destination.longitude));
    } else {
      bounds = LatLngBounds(
          southwest: LatLng(pickup.latitud, pickup.longitude),
          northeast: LatLng(destination.latitud, destination.longitude));
    }
    mapController?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 70));

    return GoogleMap(
        padding: EdgeInsets.only(bottom: mapBottomPadding),
        mapType: MapType.normal,
        polylines: _polylines,
        myLocationButtonEnabled: true,
        initialCameraPosition: _cameraPosition,
        myLocationEnabled: true,
        zoomControlsEnabled: true,
        zoomGesturesEnabled: true,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          mapController = controller;

          setState(() {
            mapBottomPadding = (Platform.isIOS) ? 270 : 280;
          });
          setupPositionLocator();
        });
  }

  void setupPositionLocator() async {
    Position currentPosition = await HelperMethods.determinePosition();
    LatLng position = LatLng(currentPosition.latitude, currentPosition.longitude);
    CameraPosition cp = CameraPosition(target: position, zoom: 14.0);
    mapController?.animateCamera(CameraUpdate.newCameraPosition(cp));
    Address? address = await HelperMethods.findCoordsAddress(currentPosition);

    if (address != null) {
      if (!mounted) return;
      Provider.of<AppData>(context, listen: false).updatePickupAddress(address);
    }
  }
}
