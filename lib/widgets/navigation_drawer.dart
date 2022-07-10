import 'package:ecoride/resources/ride_colors.dart';
import 'package:ecoride/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'custom_divider.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.white,
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
                            Text(
                              Strings.viewProfile,
                              style: TextStyle(color: RideColors.blue),
                            )
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
            navItem(Strings.navItem1, LineIcons.bell),
            navItem(Strings.navItem2, LineIcons.gift),
            navItem(Strings.navItem3, LineIcons.calendarAlt),
            navItem(Strings.navItem4, LineIcons.wallet),
            navItem(Strings.navItem5, LineIcons.star),
            navItem(Strings.navItem6, LineIcons.questionCircle),
          ],
        ));
  }

  ListTile navItem(String name, IconData icon) {
    return ListTile(
      leading: Icon(
        icon,
        color: RideColors.blue,
      ),
      title: Text(
        name,
        style: const TextStyle(fontSize: 16.0),
      ),
    );
  }
}
