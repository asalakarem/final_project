class RequestsModel {
  final int? requestId;
  final String? status;
  final String? submissionTime;
  final String? streetAddress;
  final String? missionDoneDate;
  final String? acceptedDate;
  final String? missionDoneNgo;

  RequestsModel({
    this.requestId,
    this.status,
    this.submissionTime,
    this.streetAddress,
    this.missionDoneDate,
    this.acceptedDate,
    this.missionDoneNgo,
  });

  factory RequestsModel.fromJson(Map<String, dynamic> json) {
    return RequestsModel(
      requestId: json['requestId'],
      status: json['status'],
      submissionTime: json['submissionTime'],
      streetAddress: json['streetAddress'],
      missionDoneDate: json['missionDoneDate'],
      acceptedDate: json['acceptedDate'],
      missionDoneNgo: json['missionDoneNgo'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'requestId': requestId,
      'status': status,
      'submissionTime': submissionTime,
      'streetAddress': streetAddress,
      'missionDoneDate': missionDoneDate,
      'acceptedDate': acceptedDate,
      'missionDoneNgo': missionDoneNgo,
    };
  }
}
