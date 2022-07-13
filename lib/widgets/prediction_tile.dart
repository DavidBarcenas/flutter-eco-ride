import 'package:ecoride/models/prediction.dart';
import 'package:flutter/material.dart';

import '../resources/ride_colors.dart';

class PredictionTile extends StatelessWidget {
  final Prediction prediction;

  const PredictionTile({Key? key, required this.prediction}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {},
      child: Row(
        children: [
          const Icon(
            Icons.location_city,
            color: RideColors.dimText,
          ),
          const SizedBox(
            width: 2.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                prediction.name,
                style: const TextStyle(fontSize: 16.0),
              ),
              const SizedBox(
                height: 2.0,
              ),
              Text(
                prediction.street,
                style: const TextStyle(fontSize: 12.0, color: RideColors.dimText),
              )
            ],
          )
        ],
      ),
    );
  }
}
