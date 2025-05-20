import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<String>> fetchCountries() async {
    final response = await http.get(
      Uri.parse("https://restcountries.com/v3.1/all?fields=name"),
    );
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data.map((c) => c['name']['common'] as String).toList();
    } else {
      throw Exception("Failed to load countries");
    }
  }
}
