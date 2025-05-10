class UserModel {
  final int? userId;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? password;
  final int? phoneNumber;
  final String? dateJoined;
  final int? otp;

  UserModel({
    this.userId,
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.phoneNumber,
    this.dateJoined,
    this.otp,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'],
      phoneNumber: json['phoneNumber'],
      dateJoined: json['dateJoined'],
      otp: json['otp'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'dateJoined': dateJoined,
      'otp': otp,
    };
  }
}
