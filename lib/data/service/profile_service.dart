import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../../core/constants/endpoin_constan.dart';

import '../model/profile_model.dart';

class ProfileService {
  final secureStorage = FlutterSecureStorage();

  Future<ProfileModel> getProfile() async {
    final token = await secureStorage.read(key: "token");
    if (token == null) {
      throw "Token tidak ditemukan. Silakan login ulang.";
    }
    final response = await http.get(
      Uri.parse("${ApiConstants.baseUrl}/profile/me"),
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    print("Response Profile: ${response.body}");
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);

      if (body["data"] == null) {
        throw "Format data tidak valid";
      }
      return ProfileModel.fromJson(body["data"]);
    } else {
      throw "Gagal mendapatkan profil (${response.statusCode})";
    }
  }
  Future<Map<String, dynamic>> updateLocationApi(Map<String, dynamic> data) async {
  final token = await secureStorage.read(key: "token");
  if (token == null) {
    throw "Token tidak ditemukan. Silakan login ulang.";
  }

  final url = Uri.parse("${ApiConstants.baseUrl}/profile/update-location");

  print("KIRIM DATA KE API: ${jsonEncode(data)}");

  final response = await http.post(
    url,
    headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token", // <-- WAJIB ADA
    },
    body: jsonEncode(data),
  );

  print("STATUS update-location: ${response.statusCode}");
  print("RESPON update-location: ${response.body}");

  return {
    "status": response.statusCode,
    "body": jsonDecode(response.body),
  };
}

}
