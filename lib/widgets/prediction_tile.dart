import 'package:ecoride/models/address.dart';
import 'package:ecoride/models/prediction.dart';
import 'package:ecoride/providers/app_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../resources/ride_colors.dart';

class PredictionTile extends StatelessWidget {
  final Prediction prediction;

  const PredictionTile({Key? key, required this.prediction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        Address destination = Address(
            placeName: prediction.name,
            latitud: prediction.lat,
            longitude: prediction.lon,
            placeId: prediction.placeId,
            formattedAddress: prediction.street);
        Provider.of<AppData>(context, listen: false).updateDestinationpAddress(destination);
        Navigator.pop(context, 'getDirection');
      },
      child: Row(
        children: [
          const Icon(
            Icons.location_on,
            color: RideColors.dimText,
          ),
          const SizedBox(
            width: 10.0,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  prediction.name,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 16.0, color: RideColors.text),
                ),
                const SizedBox(
                  height: 2.0,
                ),
                Text(
                  prediction.street,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12.0, color: RideColors.dimText),
                ),
                const SizedBox(
                  height: 2.0,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
