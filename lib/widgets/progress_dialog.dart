import 'package:ecoride/resources/ride_colors.dart';
import 'package:flutter/material.dart';

class ProgressDialog extends StatelessWidget {
  final String text;
  const ProgressDialog({Key? key, status, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      backgroundColor: Colors.transparent,
      child: Container(
        margin: const EdgeInsets.all(16.0),
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(4)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              const SizedBox(
                width: 5.0,
              ),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(RideColors.accent),
              ),
              const SizedBox(
                width: 25.0,
              ),
              Text(
                text,
                style: const TextStyle(fontSize: 15.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
