import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/constants/endpoin_constan.dart';
import '../model/auth_singup_model.dart';

class AuthService {

  Future<Map<String, dynamic>> signup(SignupRequest request) async {
    final url = Uri.parse("${ApiConstants.baseUrl}/signup");
    print("object@@@: ${request.toJson()}");
    final response = await http.post(
      url,
      body: request.toJson(),
    );
    final data = jsonDecode(response.body);

    print("object@@@: ${response.statusCode}");
    print("object@@@: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      final message = data['message'];
      throw message;
    }
  }

  Future<Map<String, dynamic>> signin(SigninRequest request) async {
    final url = Uri.parse("${ApiConstants.baseUrl}/signin");
    print("object@@@: ${request.toJson()}");
    final response = await http.post(
      url,
      body: request.toJson(),
    );
    final data = jsonDecode(response.body);

    print("object@@@: ${response.statusCode}");
    print("object@@@: ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      final message = data['message'];
      throw message;
    }
  }
}
