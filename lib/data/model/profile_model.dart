class ProfileModel {
  final String name;
  final String? email;
  final String mobile;
  final String status;
  final String walletBalance;
  final int orderActive;
  final String? picture;
  final String state;

  ProfileModel({
    required this.name,
    required this.email,
    required this.mobile,
    required this.status,
    required this.walletBalance,
    required this.orderActive,
    required this.picture,
    required this.state,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'] ?? '',
      email: json['email'],
      mobile: json['mobile'] ?? '',
      status: json['status'] ?? '',
      walletBalance: json['wallet_balance'] ?? '0',
      orderActive: json['order_active'] ?? 0,
      picture: json['picture'],
      state: json['state'] ?? 'offline',
    );
  }

  ProfileModel copyWith({
    String? name,
    String? email,
    String? mobile,
    String? status,
    String? walletBalance,
    int? orderActive,
    String? picture,
    String? state,
  }) {
    return ProfileModel(
      name: name ?? this.name,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      status: status ?? this.status,
      walletBalance: walletBalance ?? this.walletBalance,
      orderActive: orderActive ?? this.orderActive,
      picture: picture ?? this.picture,
      state: state ?? this.state,
    );
  }
}
