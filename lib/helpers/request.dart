import 'package:ecoride/resources/strings.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Request {
  static Future<dynamic> getRequest(String domain, String path, Map<String, String> queryParams) async {
    try {
      var url = Uri.https(domain, path, queryParams);
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        return jsonResponse;
      } else {
        return '${Strings.requestFailedStatus} : ${response.statusCode}.';
      }
    } catch (e) {
      return Strings.requestFailed;
    }
  }
}
