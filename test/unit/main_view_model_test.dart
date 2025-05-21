import 'package:dodamdodam_q/data/repository/qr_repository.dart';
import 'package:dodamdodam_q/model/qr_request.dart';
import 'package:dodamdodam_q/model/qr_response.dart';
import 'package:dodamdodam_q/model/qr_status.dart';
import 'package:dodamdodam_q/ui/view_model/main_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

class FakeQrRepository implements QrRepository {
  @override
  Future<QrResponse> sendQr(QrRequest request) async {
    if (request.memberId == 'valid') {
      return QrResponse(message: '성공', status: 200);
    } else {
      return QrResponse(message: '실패', status: 400);
    }
  }
}

void main() {
  group('MainViewModel', () {
    late MainViewModel viewModel;

    setUp(() {
      viewModel = MainViewModel(FakeQrRepository());
    });

    test('성공적인 QR 처리', () async {
      await viewModel.handleQrScan('valid', 'nonce');
      expect(viewModel.status, QrScanStatus.SUCCESS);
      expect(viewModel.message, '성공');
    });

    test('실패한 QR 처리', () async {
      await viewModel.handleQrScan('invalid', 'nonce');
      expect(viewModel.status, QrScanStatus.ERROR);
      expect(viewModel.message, '실패');
    });
  });
}
