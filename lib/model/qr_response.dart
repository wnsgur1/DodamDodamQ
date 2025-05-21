
class QrResponse {
  final String message;
  final int status;

  QrResponse({required this.message, required this.status});

  factory QrResponse.fromJson(Map<String, dynamic> json) {
    return QrResponse(
      message: json['message'] as String,
      status: json['status'] as int,
    );
  }
}