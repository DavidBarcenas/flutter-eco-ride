import 'dart:io';

import 'package:ecoride/resources/strings.dart';
import 'package:ecoride/screens/search_page.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../resources/ride_colors.dart';
import 'custom_divider.dart';

class DestinationSearchPanel extends StatelessWidget {
  DestinationSearchPanel({Key? key}) : super(key: key);
  final double searchPanelHeight = (Platform.isIOS) ? 300 : 275;

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              const Text(
                Strings.panelTitle,
                style: TextStyle(fontSize: 10),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                Strings.panelSearchLabel,
                style: TextStyle(fontSize: 18, fontFamily: 'Brand-Bold'),
              ),
              const SizedBox(
                height: 20.0,
              ),
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchPage())),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(4.0),
                  ),
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
                      Text(Strings.panelInputSearchPlaceholder)
                    ]),
                  ),
                ),
              ),
              const SizedBox(
                height: 22.0,
              ),
              _panelItem(LineIcons.home, Strings.panelHome, Strings.panelHomeDefault),
              const SizedBox(
                height: 10.0,
              ),
              const CustomDivider(),
              const SizedBox(
                height: 16.0,
              ),
              _panelItem(LineIcons.building, Strings.panelWork, Strings.panelWorkDefault)
            ],
          ),
        ),
      ),
    );
  }

  Widget _panelItem(IconData icon, String title, String address) {
    return Row(
      children: [
        Icon(
          icon,
          color: Colors.blueAccent,
        ),
        const SizedBox(
          width: 12,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title),
            const SizedBox(
              height: 3,
            ),
            Text(
              address,
              style: const TextStyle(color: RideColors.dimText, fontSize: 11),
            )
          ],
        ),
      ],
    );
  }
}
