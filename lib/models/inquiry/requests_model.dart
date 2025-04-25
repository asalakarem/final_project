class RequestsModel {
  final int? requestId;
  final String? status;
  final String? submissionTime;

  RequestsModel({this.requestId, this.status, this.submissionTime});

  factory RequestsModel.fromJson(Map<String, dynamic> json) {
    return RequestsModel(
      requestId: json['requestId'],
      status: json['status'],
      submissionTime: json['submissionTime'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'requestId': requestId,
      'status': status,
      'submissionTime': submissionTime,
    };
  }
}
