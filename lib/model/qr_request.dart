

class QrRequest {
  final String memberId;
  final String nonce;

  QrRequest({required this.memberId, required this.nonce});

  Map<String, dynamic> toJson() {
    return {
      'memberId': memberId,
      'nonce': nonce,
    };
  }
}