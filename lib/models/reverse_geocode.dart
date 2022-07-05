import 'dart:convert';

ReverseGeocode reverseGeocodeFromJson(String str) => ReverseGeocode.fromJson(json.decode(str));
String reverseGeocodeToJson(ReverseGeocode data) => json.encode(data.toJson());

class ReverseGeocode {
  ReverseGeocode({
    required this.latitude,
    required this.longitude,
    required this.continent,
    required this.lookupSource,
    required this.continentCode,
    required this.localityLanguageRequested,
    required this.city,
    required this.countryName,
    required this.countryCode,
    required this.postcode,
    required this.principalSubdivision,
    required this.principalSubdivisionCode,
    required this.plusCode,
    required this.locality,
    required this.localityInfo,
  });

  double latitude;
  double longitude;
  String continent;
  String lookupSource;
  String continentCode;
  String localityLanguageRequested;
  String city;
  String countryName;
  String countryCode;
  String postcode;
  String principalSubdivision;
  String principalSubdivisionCode;
  String plusCode;
  String locality;
  LocalityInfo localityInfo;

  factory ReverseGeocode.fromJson(Map<String, dynamic> json) => ReverseGeocode(
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        continent: json["continent"],
        lookupSource: json["lookupSource"],
        continentCode: json["continentCode"],
        localityLanguageRequested: json["localityLanguageRequested"],
        city: json["city"],
        countryName: json["countryName"],
        countryCode: json["countryCode"],
        postcode: json["postcode"],
        principalSubdivision: json["principalSubdivision"],
        principalSubdivisionCode: json["principalSubdivisionCode"],
        plusCode: json["plusCode"],
        locality: json["locality"],
        localityInfo: LocalityInfo.fromJson(json["localityInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "continent": continent,
        "lookupSource": lookupSource,
        "continentCode": continentCode,
        "localityLanguageRequested": localityLanguageRequested,
        "city": city,
        "countryName": countryName,
        "countryCode": countryCode,
        "postcode": postcode,
        "principalSubdivision": principalSubdivision,
        "principalSubdivisionCode": principalSubdivisionCode,
        "plusCode": plusCode,
        "locality": locality,
        "localityInfo": localityInfo.toJson(),
      };
}

class LocalityInfo {
  LocalityInfo({
    required this.administrative,
    required this.informative,
  });

  List<Ative> administrative;
  List<Ative> informative;

  factory LocalityInfo.fromJson(Map<String, dynamic> json) => LocalityInfo(
        administrative: List<Ative>.from(json["administrative"].map((x) => Ative.fromJson(x))),
        informative: List<Ative>.from(json["informative"].map((x) => Ative.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "administrative": List<dynamic>.from(administrative.map((x) => x.toJson())),
        "informative": List<dynamic>.from(informative.map((x) => x.toJson())),
      };
}

class Ative {
  Ative({
    required this.name,
    required this.description,
    required this.order,
    this.isoName,
    this.adminLevel,
    this.isoCode,
    this.wikidataId,
    this.geonameId,
  });

  String name;
  String description;
  String? isoName;
  int order;
  int? adminLevel;
  String? isoCode;
  String? wikidataId;
  int? geonameId;

  factory Ative.fromJson(Map<String, dynamic> json) => Ative(
        name: json["name"],
        description: json["description"],
        isoName: json["isoName"],
        order: json["order"],
        adminLevel: json["adminLevel"],
        isoCode: json["isoCode"],
        wikidataId: json["wikidataId"],
        geonameId: json["geonameId"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "isoName": isoName,
        "order": order,
        "adminLevel": adminLevel,
        "isoCode": isoCode,
        "wikidataId": wikidataId,
        "geonameId": geonameId,
      };
}
