import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Image(
      image: AssetImage('images/logo.png'),
      alignment: Alignment.center,
      height: 100.0,
      width: 100.0,
    );
  }
}
