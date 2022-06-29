import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  final Color color;
  final VoidCallback onPressed;

  const Button(
      {Key? key,
      required this.title,
      required this.color,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: color,
          onPrimary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
        ),
        child: SizedBox(
          height: 50,
          child: Center(
            child: Text(
              title,
              style: const TextStyle(fontSize: 18, fontFamily: 'Brand-Bold'),
            ),
          ),
        ));
  }
}
