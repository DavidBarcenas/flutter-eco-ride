import 'package:ecoride/resources/strings.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'custom_divider.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                        Text(Strings.viewProfile)
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
        navItem(Strings.navItem1, LineIcons.accessibleIcon),
        navItem(Strings.navItem2, LineIcons.accessibleIcon),
        navItem(Strings.navItem3, LineIcons.accessibleIcon),
        navItem(Strings.navItem4, LineIcons.accessibleIcon),
        navItem(Strings.navItem5, LineIcons.accessibleIcon),
      ],
    ));
  }

  ListTile navItem(String name, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(
        name,
        style: const TextStyle(fontSize: 16.0),
      ),
    );
  }
}
