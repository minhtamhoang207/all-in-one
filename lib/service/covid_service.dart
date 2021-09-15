import 'package:http/http.dart' as http;

class CovidService {
  static final baseUrl = "https://api.zingnews.vn/public/v2/corona/getChart?loc=hanoi";

  static Future<http.Response> getRequest() async {

    http.Response response;

    final url = Uri.parse(baseUrl);

    try {
      response = await http.get(url);
    } on Exception catch (e) {
      throw e;
    }
    return response;
  }
}