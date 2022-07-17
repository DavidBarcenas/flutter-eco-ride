class Prediction {
  String placeId;
  String name;
  String street;
  double lat;
  double lon;

  Prediction({required this.placeId, required this.name, required this.street, required this.lat, required this.lon});

  factory Prediction.fromJson(Map<String, dynamic> json) => Prediction(
      placeId: json['properties']['place_id'],
      name: json['properties']['name'] ?? '',
      street: json['properties']['formatted'],
      lat: json['properties']['lat'],
      lon: json['properties']['lon']);
}
