import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
// static const String baseUrl = 'http://127.0.0.1:8000';
static const String baseUrl = 'http://192.168.1.113:8000';
  // Use 'http://localhost:8000' for iOS simulator or Flutter web

  static Future<http.Response> registerUser({
    required String email,
    required String username,
    required String password,
    required String experienceLevel,
    required double weight,
    required double height,
    required String gymGoals,
  }) async {
    final url = Uri.parse('$baseUrl/auth/register');
    final body = {
      'email': email,
      'username': username,
      'password': password,
      'experience_level': experienceLevel,
      'weight': weight,
      'height': height,
      'gym_goals': gymGoals,
    };

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    return response;
  }

  static Future<http.Response> loginUser({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/auth/login');
    final body = {
      'email': email,
      'password': password,
    };

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    return response;
  }
}
