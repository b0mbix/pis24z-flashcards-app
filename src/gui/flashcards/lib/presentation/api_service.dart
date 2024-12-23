import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static const String baseUrl = "http://127.0.0.1:8000/api/";

  Future<Map<String, dynamic>> fetchExampleData() async {
    final url = Uri.parse("${baseUrl}example/");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return json.decode(response.body); // Return JSON data as a map
    } else {
      throw Exception('Failed to load data from Django');
    }
  }
}
