class Address {
  Address({
    required this.placeName,
    required this.latitud,
    required this.longitude,
    required this.placeId,
    required this.placeFormattedAddress,
  });

  String placeName;
  double latitud;
  double longitude;
  String placeId;
  String placeFormattedAddress;
}
