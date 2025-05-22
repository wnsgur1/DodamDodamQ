import 'package:dodamdodam_q/model/qr_request.dart';
import 'package:dodamdodam_q/model/qr_response.dart';
import 'package:dodamdodam_q/model/qr_status.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dodamdodam_q/ui/view_model/main_view_model.dart';
import 'package:dodamdodam_q/data/repository/qr_repository.dart';
import 'package:mockito/mockito.dart';

class MockQrRepository extends Mock implements QrRepository {}

void main() {
  group('MainViewModel Unit Tests', () {
    late MainViewModel viewModel;
    late MockQrRepository mockRepository;

    setUp(() {
      mockRepository = MockQrRepository();
      viewModel = MainViewModel(mockRepository);
    });

    test('200 응답 시 상태가 SUCCESS로 설정되어야 함', () async {
      when(mockRepository.sendQr(QrRequest(memberId: "memberId", nonce: "nonce"))).thenAnswer(
            (_) async => QrResponse(status: 200, message: 'Success'),
      );

      await viewModel.handleQrScan('member123', 'nonce456');

      expect(viewModel.status, QrScanStatus.SUCCESS);
      expect(viewModel.message, 'Success');
    });

    test('200 외의 응답 시 상태가 ERROR로 설정되어야 함', () async {
      when(mockRepository.sendQr(QrRequest(memberId: "memberId", nonce: "nonce"))).thenAnswer(
            (_) async => QrResponse(status: 400, message: 'Error'),
      );

      await viewModel.handleQrScan('member123', 'nonce456');



      
      expect(viewModel.status, QrScanStatus.ERROR);
      expect(viewModel.message, 'Error');
    });
  });
}
