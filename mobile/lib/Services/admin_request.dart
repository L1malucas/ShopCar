import 'dart:convert';
import 'package:http/http.dart' as http;

import '../utils/constants.dart';

class LoginService {
  static Future<Map<String, dynamic>> loginUser(
      String username, String password) async {
    username = username.trim().toLowerCase();
    password = password.trim().toLowerCase();
    const loginUrl = '${Constants.apiAzure}/login';

    final response = await http.post(
      Uri.parse(loginUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      final token = responseData['token'];
      final adminData = responseData['admin'];

      if (adminData != null) {
        final role = adminData['role'];
        Constants.adminToken = token;
        return {
          'token': token,
          'role': role,
        };
      } else {
        throw Exception('Failed to get user data from the response');
      }
    } else {
      throw Exception('Failed to login');
    }
  }
}
