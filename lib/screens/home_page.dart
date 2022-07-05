import 'package:ecoride/helpers/helper_methods.dart';
import 'package:ecoride/resources/ride_colors.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'dart:async';
import 'dart:io';

import '../widgets/custom_divider.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final Completer<GoogleMapController> _controller = Completer();
  late GoogleMapController mapController;
  double mapBottomPadding = 0;
  double searchPanelHeight = (Platform.isIOS) ? 300 : 275;
  late Position userPosition;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  void setupPositionLocator() async {
    Position position = await _determinePosition();
    userPosition = position;

    LatLng pos = LatLng(position.latitude, position.longitude);
    CameraPosition cp = CameraPosition(target: pos, zoom: 14.0);
    mapController.animateCamera(CameraUpdate.newCameraPosition(cp));

    String address = await HelperMethods.findCoordsAddress(position, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        drawer: Container(
          width: 250,
          color: Colors.white,
          child: Drawer(
              child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                  color: Colors.white,
                  height: 160.0,
                  child: DrawerHeader(
                    decoration: const BoxDecoration(color: Colors.white),
                    child: Row(
                      children: [
                        Image.asset(
                          'images/user_icon.png',
                          height: 60.0,
                          width: 60.0,
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'David Bárcenas',
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: 'Brand-Bold',
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text('Ver perfil')
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
              const CustomDivider(),
              const SizedBox(
                height: 10.0,
              ),
              const ListTile(
                leading: Icon(LineIcons.accessibleIcon),
                title: Text(
                  'Viajes gratis',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              const ListTile(
                leading: Icon(LineIcons.accessibleIcon),
                title: Text(
                  'Pagos',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              const ListTile(
                leading: Icon(LineIcons.accessibleIcon),
                title: Text(
                  'Historial',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              const ListTile(
                leading: Icon(LineIcons.accessibleIcon),
                title: Text(
                  'Soporte',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
              const ListTile(
                leading: Icon(LineIcons.accessibleIcon),
                title: Text(
                  'Acerca de',
                  style: TextStyle(fontSize: 16.0),
                ),
              ),
            ],
          )),
        ),
        body: Stack(
          children: [
            GoogleMap(
                padding: EdgeInsets.only(bottom: mapBottomPadding),
                mapType: MapType.normal,
                myLocationButtonEnabled: true,
                initialCameraPosition: _kGooglePlex,
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
                }),
            Positioned(
              top: 44,
              left: 20,
              child: GestureDetector(
                onTap: () => scaffoldKey.currentState?.openDrawer(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: const [
                      BoxShadow(color: Colors.black26, blurRadius: 5.0, spreadRadius: 5.0, offset: Offset(0.7, 0.7))
                    ],
                  ),
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 20.0,
                    child: Icon(
                      LineIcons.bars,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                height: searchPanelHeight,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 15.0, spreadRadius: 0.5, offset: Offset(0.7, 0.7))
                    ]),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 18.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 5,
                      ),
                      const Text(
                        'Bienvenido',
                        style: TextStyle(fontSize: 10),
                      ),
                      const Text(
                        '¿A dónde quieres ir?',
                        style: TextStyle(fontSize: 18, fontFamily: 'Brand-Bold'),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4.0),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black12, blurRadius: 2.0, spreadRadius: 2.0, offset: Offset(0.7, 0.7))
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(children: const [
                            Icon(
                              Icons.search,
                              color: Colors.blueAccent,
                            ),
                            SizedBox(
                              width: 10.0,
                            ),
                            Text('Busca tu destino')
                          ]),
                        ),
                      ),
                      const SizedBox(
                        height: 22.0,
                      ),
                      Row(
                        children: [
                          const Icon(
                            LineIcons.home,
                            color: RideColors.dimText,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Agregar casa'),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Dirección de tu casa',
                                style: TextStyle(color: RideColors.dimText, fontSize: 11),
                              )
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      const CustomDivider(),
                      const SizedBox(
                        height: 16.0,
                      ),
                      Row(
                        children: [
                          const Icon(
                            LineIcons.building,
                            color: RideColors.dimText,
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text('Agregar trabajo'),
                              SizedBox(
                                height: 3,
                              ),
                              Text(
                                'Dirección de tu trabajo',
                                style: TextStyle(color: RideColors.dimText, fontSize: 11),
                              )
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
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
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error('Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
}
