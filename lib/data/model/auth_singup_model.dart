class SignupRequest {
  final String name;
  final String mobile;
  final String password;
  final String deviceId;
  final String deviceType;
  final String imei1;
  final String imei2;

  SignupRequest({
    required this.name,
    required this.mobile,
    required this.password,
    required this.deviceId,
    required this.deviceType,
    required this.imei1,
    required this.imei2,
  });

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "mobile": mobile,
      "password": password,
      "device_id": deviceId,
      "device_type": deviceType,
      "imei1": imei1,
      "imei2": imei2,
    };
  }
}

class SigninRequest {
  final String mobile;
  final String password;
  final String deviceId;
  final String imei1;
  final String imei2;

  SigninRequest({
    required this.mobile,
    required this.password,
    required this.deviceId,
    required this.imei1,
    required this.imei2,
  });

  Map<String, dynamic> toJson() {
    return {
      "mobile": mobile,
      "password": password,
      "device_id": deviceId,
      "imei1": imei1,
      "imei2": imei2,
    };
  }
}
