class UserModel {
  final String userId;      
  final String username;
  final String email;
  final String phoneNumber;
  final String password;      
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
      "userId": userId,  
      "username": username,
      "email": email,
      "phoneNumber": phoneNumber,
      "password": password,
      "walletBalance": walletBalance,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> data, String uid) {
    return UserModel(
      userId: uid,
      username: data["username"] ?? "",
      email: data["email"] ?? "",
      phoneNumber: data["phoneNumber"] ?? "",
      password: data["password"] ?? "",
      walletBalance: (data["walletBalance"] ?? 0).toDouble(),
    );
  }
}
