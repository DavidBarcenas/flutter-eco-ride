import 'package:ecoride/resources/strings.dart';
import 'package:ecoride/screens/search_page.dart';
import 'package:ecoride/widgets/progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:provider/provider.dart';

import '../helpers/helper_methods.dart';
import '../providers/app_data.dart';
import '../resources/ride_colors.dart';
import 'custom_divider.dart';

class DestinationSearchPanel extends StatefulWidget {
  final double panelHeight;
  final Function showPanel;
  const DestinationSearchPanel({Key? key, required this.panelHeight, required this.showPanel}) : super(key: key);

  @override
  State<DestinationSearchPanel> createState() => _DestinationSearchPanelState();
}

class _DestinationSearchPanelState extends State<DestinationSearchPanel> {
  Future<void> getDirection() async {
    var pickup = Provider.of<AppData>(context, listen: false).pickupAddress;
    var destination = Provider.of<AppData>(context, listen: false).destinationAddress;
    var pickupLatLng = LatLng(pickup.latitud, pickup.longitude);
    var destinationLatLng = LatLng(destination.latitud, destination.longitude);

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => const ProgressDialog(
              text: 'Espera por favor...',
            ));

    var details = await HelperMethods.getDirectionDetails(pickupLatLng, destinationLatLng);
    if (!mounted) return;
    if (details?.points != null) {
      Provider.of<AppData>(context, listen: false).updateWaypoints(details!.points);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        height: widget.panelHeight,
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
                onTap: () async {
                  var response =
                      await Navigator.push(context, MaterialPageRoute(builder: (context) => const SearchPage()));
                  if (response == 'getDirection') {
                    await getDirection();
                    widget.showPanel();
                  }
                },
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
