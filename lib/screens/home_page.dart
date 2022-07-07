import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'dart:io';

import '../widgets/destination_search_panel.dart';
import '../widgets/map.dart';
import '../widgets/navigation_drawer.dart';

class HomePage extends StatefulWidget {
  static const String id = 'home';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  late GoogleMapController mapController;
  double mapBottomPadding = 0;
  double searchPanelHeight = (Platform.isIOS) ? 300 : 275;
  late Position userPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        drawer: Container(width: 250, color: Colors.white, child: const NavigationDrawer()),
        body: Stack(
          children: [
            const GMap(),
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
            DestinationSearchPanel()
          ],
        ));
  }
}
