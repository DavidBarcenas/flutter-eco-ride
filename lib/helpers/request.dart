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
        return 'Request failed with status: ${response.statusCode}.';
      }
    } catch (e) {
      return 'Request failed';
    }
  }
}
