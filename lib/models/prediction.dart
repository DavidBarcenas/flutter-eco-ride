class Prediction {
  String placeId;
  String name;
  String street;

  Prediction({required this.placeId, required this.name, required this.street});

  factory Prediction.fromJson(Map<String, dynamic> json) => Prediction(
      placeId: json['properties']['place_id'], name: json['properties']['name'], street: json['properties']['street']);
}
