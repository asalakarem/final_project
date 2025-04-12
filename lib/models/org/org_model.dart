class OrgModel {
  int? ngoId;
  String? name;
  String? email;
  String? password;
  int? phoneNumber;
  double? latitude;
  double? longitude;
  String? address;
  String? dateJoined;
  int? otp;

  OrgModel({
    this.ngoId,
    this.name,
    this.email,
    this.password,
    this.phoneNumber,
    this.latitude,
    this.longitude,
    this.address,
    this.dateJoined,
    this.otp,
  });

  OrgModel.fromJson(Map<String, dynamic> json) {
    ngoId = json['ngoId'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phoneNumber = json['phoneNumber'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
    dateJoined = json['dateJoined'];
    otp = json['otp'];
  }

  Map<String, dynamic> toMap() {
    return {
      'ngoId': ngoId,
      'name': name,
      'email': email,
      'password': password,
      'phoneNumber': phoneNumber,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'dateJoined': dateJoined,
      'otp': otp,
    };
  }
}
