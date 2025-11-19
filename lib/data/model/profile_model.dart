class ProfileModel {
  final String name;
  final String? email;
  final String mobile;
  final String status;
  final bool isAvailable;
  final String walletBalance;
  final int orderActive;
  final String? picture;


  ProfileModel({
    required this.name,
    required this.email,
    required this.mobile,
    required this.status,
    required this.isAvailable,
    required this.walletBalance,
    required this.orderActive,
    required this.picture,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'] ?? '',
      email: json['email'],
      mobile: json['mobile'] ?? '',
      status: json['status'] ?? '',
      isAvailable: json['is_available'] ?? false,
      walletBalance: json['wallet_balance'] ?? '0',
      orderActive: json['order_active'] ?? 0,
      picture: json['picture'],
    );
  }
}
