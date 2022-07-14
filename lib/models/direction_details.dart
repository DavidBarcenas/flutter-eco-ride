import 'package:google_maps_flutter/google_maps_flutter.dart';

class DirectionDetails {
  String distance;
  String duration;
  List<LatLng> points;

  DirectionDetails({required this.distance, required this.duration, required this.points});

  factory DirectionDetails.fromJson(Map<String, dynamic> json) => DirectionDetails(
      distance: json['properties']['distance'],
      duration: json['properties']['time'],
      points:
          (json['properties']['waypoints'] as List).map((e) => LatLng(e['location'][1], e['location'][0])).toList());
}
