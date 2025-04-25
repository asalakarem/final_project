class AcceptedModel {
  final int? requestId;
  final String? status;
  final String? submissionTime;

  AcceptedModel({this.requestId, this.status, this.submissionTime});

  factory AcceptedModel.fromJson(Map<String, dynamic> json) {
    return AcceptedModel(
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
