import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../core/constants/endpoin_constan.dart';
import '../model/vhicle_add_model.dart';
import '../model/vehicle_model.dart';

class VhicleService {
  final secureStorage = const FlutterSecureStorage();

  bool _isValidImage(File file) {
    final allowed = ["jpg", "jpeg", "png"];
    final ext = file.path.split(".").last.toLowerCase();
    return allowed.contains(ext);
  }

  Future<bool> addVhicle({
    required VhicleAddRequest data,
    required File fotoUtama,
    File? fotoStnk,
    File? fotoPajak,
  }) async {
    final token = await secureStorage.read(key: "token");
    if (token == null) throw "Token tidak ditemukan";

    final url = Uri.parse("${ApiConstants.baseUrl}/car/add");
    var request = http.MultipartRequest("POST", url);

    // Headers niru Postman
    request.headers.addAll({
      'Authorization': "Bearer $token",
      'Accept': 'application/json',
      'User-Agent': 'PostmanRuntime/7.32.2', // gabisa akses lewat mobile langsung jadi pake ini "kalo akses pake mobile ke direct ke api lain error 302"
    });

    request.fields.addAll(data.toFields());

    if (!_isValidImage(fotoUtama)) throw "Foto utama harus JPG, JPEG, PNG";
    if (fotoStnk != null && !_isValidImage(fotoStnk)) {
      throw "Foto STNK tidak valid";
    }
    if (fotoPajak != null && !_isValidImage(fotoPajak)) {
      throw "Foto Pajak tidak valid";
    }

    request.files.add(await http.MultipartFile.fromPath(
      "picture",
      fotoUtama.path,
    ));

    if (fotoStnk != null) {
      request.files.add(await http.MultipartFile.fromPath(
        "stnk",
        fotoStnk.path,
      ));
    }

    if (fotoPajak != null) {
      request.files.add(await http.MultipartFile.fromPath(
        "pajak",
        fotoPajak.path,
      ));
    }

    final response = await request.send();
    final respStr = await response.stream.bytesToString();

    print("TOKEN: $token");
    print("STATUS CODE: ${response.statusCode}");
    print("RESPONSE BODY: $respStr");

    return response.statusCode == 200 || response.statusCode == 201;
  }

  Future<List<VehicleModel>> getVehicleList() async {
    final token = await secureStorage.read(key: "token");
    if (token == null) throw "Token tidak ditemukan";

    final url = Uri.parse("${ApiConstants.baseUrl}/car/list");
    // final url = Uri.parse("https://mocki.io/v1/0b202311-f587-4139-9822-6dfb7c570926"); //fake api for testing

    final response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );

    final body = jsonDecode(response.body);

    if (response.statusCode != 200 || body["success"] != true) {
      throw "Gagal memuat kendaraan";
    }

    final raw = body["data"] as List<dynamic>? ?? [];

    return raw.map((e) {
      if (e is Map<String, dynamic>) {
        return VehicleModel.fromJson(e);
      } else {
        return VehicleModel.fromJson(Map<String, dynamic>.from(e));
      }
    }).toList();
  }
}
