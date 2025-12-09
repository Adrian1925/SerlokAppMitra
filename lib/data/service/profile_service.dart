import 'dart:convert';
import 'dart:io';
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
    final url =("${ApiConstants.baseUrl}/profile/me");
    // fake api for testing ----------------------------------------
    // final url = "https://mocki.io/v1/abe289c9-710f-4d9c-bb93-01209da70ebc"; // (active account) 
    // final url = "https://mocki.io/v1/a32fd0d9-72a8-42e5-9fd0-0056e7745e48"; // (pending account)
    // final url = "https://mocki.io/v1/a32fd0d9-72a8-42e5-9fd0-0056e7745e48"; // (active with wallet balance < 10000 account)
    
    final response = await http.get(
      Uri.parse(url),
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

  Future<Map<String, dynamic>> updateLocationApi(
      Map<String, dynamic> data) async {
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
        "Authorization": "Bearer $token",
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

  Future<Map<String, dynamic>> uploadSelfie(File file) async {
    final token = await secureStorage.read(key: "token");
    if (token == null) throw "Token tidak ditemukan. Silakan login ulang.";

    final request = http.MultipartRequest(
      'POST',
      Uri.parse("${ApiConstants.baseUrl}/profile/add-selfie"),
    );

    request.headers['Authorization'] = "Bearer $token";

    request.files.add(
      await http.MultipartFile.fromPath("selfie", file.path),
    );

    final response = await request.send();
    final resBody = await response.stream.bytesToString();

    print("STATUS selfie: ${response.statusCode}");
    print("RESPON selfie: $resBody");

    return {
      "status": response.statusCode,
      "body": jsonDecode(resBody),
    };
  }

  Future<Map<String, dynamic>> uploadKtp(File file) async {
    final token = await secureStorage.read(key: "token");
    if (token == null) throw "Token tidak ditemukan. Silakan login ulang.";

    final request = http.MultipartRequest(
      'POST',
      Uri.parse("${ApiConstants.baseUrl}/profile/add-ktp"),
    );

    request.headers['Authorization'] = "Bearer $token";

    request.files.add(
      await http.MultipartFile.fromPath("ktp", file.path),
    );

    final response = await request.send();
    final resBody = await response.stream.bytesToString();

    print("STATUS KTP: ${response.statusCode}");
    print("RESPON KTP: $resBody");

    return {
      "status": response.statusCode,
      "body": jsonDecode(resBody),
    };
  }

  Future<Map<String, dynamic>> uploadAddress(String address) async {
    final token = await secureStorage.read(key: "token");
    if (token == null) throw "Token tidak ditemukan. Silakan login ulang.";

    final url = Uri.parse("${ApiConstants.baseUrl}/profile/add-address");

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonEncode({"address": address}),
    );

    print("STATUS address: ${response.statusCode}");
    print("RESPON address: ${response.body}");

    return {
      "status": response.statusCode,
      "body": jsonDecode(response.body),
    };
  }

  Future<Map<String, dynamic>> changeState(String state) async {
  final token = await secureStorage.read(key: "token");
  if (token == null) throw "Token tidak ditemukan. Silakan login ulang.";

  final request = http.MultipartRequest(
    'POST',
    Uri.parse("${ApiConstants.baseUrl}/profile/change-state"),
  );

  request.headers['Authorization'] = "Bearer $token";

  request.fields['state'] = state; 

  final response = await request.send();
  final resBody = await response.stream.bytesToString();

  print("STATUS change-state: ${response.statusCode}");
  print("RESPON change-state: $resBody");

  return {
    "status": response.statusCode,
    "body": jsonDecode(resBody),
  };
}

}
