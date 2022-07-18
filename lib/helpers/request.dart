import 'package:ecoride/resources/strings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Request {
  static Future<dynamic> getRequest(String url) async {
    try {
      http.Response response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        return jsonResponse;
      } else {
        return Strings.requestFailed;
      }
    } catch (e) {
      return Strings.requestFailed;
    }
  }
}
