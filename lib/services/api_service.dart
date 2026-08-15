import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = "http://study-planner-api.test/api";

  static Future<Map<String, dynamic>> post(String endpoint, Map<String, dynamic> data) async {
    final response = await http.post(
      Uri.parse("$baseUrl/$endpoint"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(data),
    );
    return {
      "statusCode": response.statusCode,
      "body": jsonDecode(response.body),
    };
  }

  static Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(Uri.parse("$baseUrl/$endpoint"));
    return {
      "statusCode": response.statusCode,
      "body": jsonDecode(response.body),
    };
  }
}