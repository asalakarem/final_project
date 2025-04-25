class InProgressModel {
  final int? requestId;
  final String? status;
  final String? submissionTime;

  InProgressModel({this.requestId, this.status, this.submissionTime});

  factory InProgressModel.fromJson(Map<String, dynamic> json) {
    return InProgressModel(
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
