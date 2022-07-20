import 'dart:async';
import 'dart:io';

import 'package:ecoride/models/address.dart';
import 'package:ecoride/resources/ride_colors.dart';
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
  Set<Marker> _markers = {};
  Set<Circle> _circles = {};

  static const CameraPosition _cameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    polylineCoords = Provider.of<AppData>(context, listen: true).waypoints;
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
    if (polylineCoords.isNotEmpty) {
      var pickup = Provider.of<AppData>(context, listen: false).pickupAddress;
      var destination = Provider.of<AppData>(context, listen: false).destinationAddress;
      var pickupLatLng = LatLng(pickup.latitud, pickup.longitude);
      var destinationLatLng = LatLng(destination.latitud, destination.longitude);
      if (pickupLatLng.latitude > destinationLatLng.latitude && pickupLatLng.longitude > destinationLatLng.longitude) {
        bounds = LatLngBounds(southwest: destinationLatLng, northeast: pickupLatLng);
      } else if (pickupLatLng.longitude > destinationLatLng.longitude) {
        bounds = LatLngBounds(
            southwest: LatLng(pickupLatLng.latitude, destinationLatLng.longitude),
            northeast: LatLng(destinationLatLng.latitude, pickupLatLng.longitude));
      } else if (pickupLatLng.latitude > destinationLatLng.latitude) {
        bounds = LatLngBounds(
            southwest: LatLng(destinationLatLng.latitude, pickupLatLng.longitude),
            northeast: LatLng(pickupLatLng.latitude, destinationLatLng.longitude));
      } else {
        bounds = LatLngBounds(southwest: pickupLatLng, northeast: destinationLatLng);
      }
      mapController?.animateCamera(CameraUpdate.newLatLngBounds(bounds, 70));
      Marker pickupMarker = Marker(
          markerId: const MarkerId("m_pickup"),
          position: pickupLatLng,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          infoWindow: InfoWindow(title: pickup.placeName, snippet: 'My location'));
      Marker destinationMarker = Marker(
          markerId: const MarkerId("m_destination"),
          position: destinationLatLng,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: InfoWindow(title: pickup.placeName, snippet: 'Destination'));
      Circle pickupCircle = Circle(
          circleId: const CircleId('c_pickup'),
          strokeColor: Colors.green,
          strokeWidth: 3,
          radius: 12,
          center: pickupLatLng,
          fillColor: RideColors.green);
      Circle destinationCircle = Circle(
          circleId: const CircleId('c_destination'),
          strokeColor: Colors.blue,
          strokeWidth: 3,
          radius: 12,
          center: pickupLatLng,
          fillColor: RideColors.accentPurple);

      setState(() {
        _markers.add(pickupMarker);
        _markers.add(destinationMarker);
        _circles.add(pickupCircle);
        _circles.add(destinationCircle);
      });
    }

    return GoogleMap(
        padding: EdgeInsets.only(bottom: mapBottomPadding),
        mapType: MapType.normal,
        polylines: _polylines,
        markers: _markers,
        circles: _circles,
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
