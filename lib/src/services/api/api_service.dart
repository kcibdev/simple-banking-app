import 'package:http/http.dart' as http;

class ApiService {
  Future<http.Response> getData(String url) async {
    http.Response response = await http.get(Uri.parse(url));
    return response;
  }

  Future<http.Response> postData(String url, Map body) async {
    http.Response response = await http.post(Uri.parse(url), body: body);
    return response;
  }
}
