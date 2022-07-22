import 'package:ecoride/resources/ride_colors.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../widgets/button.dart';
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
                      BoxShadow(color: Colors.black26, blurRadius: 3.0, spreadRadius: 2.0, offset: Offset(0.7, 0.7))
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
            const DestinationSearchPanel(),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(color: Colors.black26, blurRadius: 15.0, spreadRadius: 0.5, offset: Offset(0.7, 0.7))
                    ]),
                height: 300,
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      color: Colors.blue[50],
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Image.asset(
                              'images/taxi.png',
                              height: 70,
                              width: 70,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Taxi', style: TextStyle(fontSize: 18, fontFamily: 'Brand-Bold')),
                                Text('14km', style: TextStyle(fontSize: 16, color: RideColors.textLight)),
                              ],
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            const Text(
                              '\$52',
                              style: TextStyle(fontSize: 18, fontFamily: 'Brand-Bold'),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 22,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Button(title: 'Solicitar Ride', color: RideColors.blue, onPressed: () {}),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
