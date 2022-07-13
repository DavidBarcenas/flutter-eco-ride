class Address {
  String placeName;
  double latitud;
  double longitude;
  String placeId;
  String formattedAddress;

  Address({
    required this.placeName,
    required this.latitud,
    required this.longitude,
    required this.placeId,
    required this.formattedAddress,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
      placeName: '${json['name']}, ${json['street']}',
      latitud: json['lat'],
      longitude: json['lon'],
      placeId: json['place_id'],
      formattedAddress: json['formatted']);
}
