class RequestModel {
  int? userId;
  String? status;
  double? latitude;
  double? longitude;
  String? submissionTime;
  String? description;
  String? dogImage;
  int? dogCount;

  RequestModel({
    this.userId,
    this.status,
    this.latitude,
    this.longitude,
    this.submissionTime,
    this.description,
    this.dogImage,
    this.dogCount,
  });

  RequestModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    status = json['status'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    submissionTime = json['submissionTime'];
    description = json['description'];
    dogImage = json['dogImage'];
    dogCount = json['dogCount'];
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'status': status,
      'latitude': latitude,
      'longitude': longitude,
      'submissionTime': submissionTime,
      'description': description,
      'dogImage': dogImage,
      'dogCount': dogCount,
    };
  }
}
