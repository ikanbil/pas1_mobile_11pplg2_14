import 'dart:convert';
import 'package:http/http.dart' as http;

import 'login_model.dart';

class LoginService {
  final String _baseUrl = "https://mediadwi.com/api/latihan/login";

  Future<LoginModel> login(String username, String password) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: {
        "username": username,
        "password": password,
      },
    );

    if (response.statusCode == 200) {
      return LoginModel.fromJson(json.decode(response.body));
    } else {
      throw Exception("Failed to login");
    }
  }
}
