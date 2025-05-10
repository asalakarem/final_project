class CreateRequestModel {
  final int? userId;
  final String? status;
  final double? latitude;
  final double? longitude;
  final String? streetAddress;
  final String? submissionTime;
  final String? description;
  final String? dogImage;
  final int? dogCount;

  CreateRequestModel({
    required this.userId,
    required this.status,
    required this.latitude,
    required this.longitude,
    required this.streetAddress,
    required this.submissionTime,
    required this.description,
    required this.dogImage,
    required this.dogCount,
  });

  factory CreateRequestModel.fromJson(Map<String, dynamic> json) {
    return CreateRequestModel(
      userId: json['userId'],
      status: json['status'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      streetAddress: json['streetAddress'],
      submissionTime: json['submissionTime'],
      description: json['description'],
      dogImage: json['dogImage'],
      dogCount: json['dogCount'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'status': status,
      'latitude': latitude,
      'longitude': longitude,
      'streetAddress': streetAddress,
      'submissionTime': submissionTime,
      'description': description,
      'dogImage': dogImage,
      'dogCount': dogCount,
    };
  }
}
