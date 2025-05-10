class OrgModel {
  final int? ngoId;
  final String? name;
  final String? email;
  final String? password;
  final int? phoneNumber;
  final double? latitude;
  final double? longitude;
  final String? address;
  final String? dateJoined;
  final int? otp;
  final int? isActive;

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
    this.isActive,
  });

  factory OrgModel.fromJson(Map<String, dynamic> map) {
    return OrgModel(
      ngoId: map['ngoId']?.toInt(),
      name: map['name'],
      email: map['email'],
      password: map['password'],
      phoneNumber: map['phoneNumber']?.toInt(),
      latitude: map['latitude']?.toDouble(),
      longitude: map['longitude']?.toDouble(),
      address: map['address'],
      dateJoined: map['dateJoined'],
      otp: map['otp']?.toInt(),
      isActive: map['isActive']?.toInt(),
    );
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
      'isActive': isActive,
    };
  }
}
