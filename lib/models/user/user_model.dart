class UserModel {
  int? userId;
  String? firstName;
  String? lastName;
  String? email;
  String? password;
  String? phoneNumber;
  String? dateJoined;
  int? otp;

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

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    password = json['password'];
    phoneNumber = json['phoneNumber']?.toString();
    dateJoined = json['dateJoined']?.toString();
    otp = json['otp'] is String ? int.tryParse(json['otp']) : json['otp'];
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
