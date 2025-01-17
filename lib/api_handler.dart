import 'dart:convert';
import 'model.dart';
import 'package:http/http.dart' as http;

class ApiHandler {
  final String baseUri = "https://localhost:7063/api/Users";

  Future<List<User>> getUserData() async {
    List<User> data = [];

    final uri = Uri.parse(baseUri);
    try {
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonData = json.decode(response.body);
        data = jsonData.map((json) => User.fromJson(json)).toList();
      } else {
        print('Error: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
    } catch (e) {
      print('Exception occurred: $e');
    }
    return data;
  }
}