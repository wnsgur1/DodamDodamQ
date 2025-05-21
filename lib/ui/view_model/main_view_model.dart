import 'package:flutter/cupertino.dart';

import '../../data/repository/qr_repository.dart';
import '../../model/qr_request.dart';
import '../../model/qr_response.dart';
import '../../model/qr_status.dart';

class MainViewModel with ChangeNotifier {
  final QrRepository _qrRepository;

  MainViewModel(this._qrRepository);

  QrScanStatus? _status;
  String? _message;

  QrScanStatus? get status => _status;

  String? get message => _message;

  Future<void> handleQrScan(String memberId, String nonce) async {
    print("서버1");
    final request = QrRequest(memberId: memberId, nonce: nonce);
    try {
      final response = await _qrRepository.sendQr(request);
      print("서버2 $request, $response");

      if (response.status == 200) {
        _status = QrScanStatus.SUCCESS;
        _message = response.message;
      } else {
        _status = QrScanStatus.ERROR;
        _message = response.message;
      }
    } catch (e) {
      print("❌ 서버 통신 중 오류 발생: $e");
      _status = QrScanStatus.ERROR;
      _message = e.toString();
    }
    notifyListeners();
  }


  void reset() {
    _status = null;
    _message = null;
    notifyListeners();
  }
}
