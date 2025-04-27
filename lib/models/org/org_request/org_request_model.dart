class OrgRequestModel
{
  final int? requestId;
  final String? userName;
  final int? phoneNumber;
  final int? dogsCount;
  final String? streetAddress;
  final String? description;
  final double? latitude;
  final double? longitude;
  final String? assignedDate;
  final String? actionDate;
  final String? status;

  OrgRequestModel({
    this.requestId,
    this.userName,
    this.phoneNumber,
    this.dogsCount,
    this.streetAddress,
    this.description,
    this.latitude,
    this.longitude,
    this.assignedDate,
    this.actionDate,
    this.status
  });

  factory OrgRequestModel.fromJson(Map<String, dynamic> json) {
    return OrgRequestModel(
      requestId: json['requestId'],
      userName: json['userName'],
      phoneNumber: json['phoneNumber'],
      dogsCount: json['dogsCount'],
      streetAddress: json['streetAddress'],
      description: json['description'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      assignedDate: json['assignedDate'],
      actionDate: json['actionDate'],
      status: json['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'requestId': requestId,
      'userName': userName,
      'phoneNumber': phoneNumber,
      'dogsCount': dogsCount,
      'streetAddress': streetAddress,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
      'assignedDate': assignedDate,
      'actionDate': actionDate,
      'status': status
    };
  }
}