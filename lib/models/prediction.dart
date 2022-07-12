class Prediction {
  String placeId;
  String mainText;
  String secondaryText;

  Prediction({required this.placeId, required this.mainText, required this.secondaryText});

  factory Prediction.fromJson(Map<String, dynamic> json) =>
      Prediction(placeId: json['place_id'], mainText: json['place_id'], secondaryText: json['place_id']);
}
