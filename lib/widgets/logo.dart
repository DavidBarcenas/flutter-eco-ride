import 'package:ecoride/resources/ride_colors.dart';
import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 125.0,
          height: 100.0,
          padding: const EdgeInsets.all(20.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(15.0), topRight: Radius.circular(15.0)),
            color: RideColors.blue,
          ),
          child: const Image(
            image: AssetImage('images/logo-white.png'),
            alignment: Alignment.center,
            height: 70.0,
            width: 70.0,
          ),
        ),
        Container(
          width: 125.0,
          padding: const EdgeInsets.symmetric(vertical: 3.0),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15.0), bottomRight: Radius.circular(15.0)),
            color: RideColors.green,
          ),
          alignment: Alignment.center,
          child: const Text(
            'ECORIDE',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 2.0),
          ),
        )
      ],
    );
  }
}
