class UserModel {
  final String userId;
  final String username;
  final String email;
  final String phoneNumber;
  final String password; // In real apps, store hash only
  final double walletBalance;

  UserModel({
    required this.userId,
    required this.username,
    required this.email,
    required this.phoneNumber,
    required this.password,
    this.walletBalance = 0.0,
  });

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
      'walletBalance': walletBalance,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> data, String id) {
    return UserModel(
      userId: id,
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      password: data['password'] ?? '',
      walletBalance: (data['walletBalance'] ?? 0).toDouble(),
    );
  }
}