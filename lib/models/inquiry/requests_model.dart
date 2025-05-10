class RequestsModel {
  final int? requestId;
  final String? status;
  final String? submissionTime;
  final String? streetAddress;
  final String? missionDoneDate;
  final String? acceptedDate;
  final String? missionDoneNgo;

  RequestsModel({
    required this.requestId,
    required this.status,
    required this.submissionTime,
    required this.streetAddress,
    required this.missionDoneDate,
    required this.acceptedDate,
    required this.missionDoneNgo,
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
