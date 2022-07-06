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
    ));
  }
}
