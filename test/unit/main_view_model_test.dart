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

    test('handleQrScan sets status to SUCCESS on 200 response', () async {
      // 정확한 QrRequest 객체로 매칭
      final expectedRequest = QrRequest(memberId: 'member123', nonce: 'nonce456');
      when(mockRepository.sendQr(expectedRequest))
          .thenAnswer((_) async => QrResponse(status: 200, message: 'Success'));

      await viewModel.handleQrScan('member123', 'nonce456');

      expect(viewModel.status, QrScanStatus.SUCCESS);
      expect(viewModel.message, 'Success');
    });

    test('handleQrScan sets status to ERROR on non-200 response', () async {
      final expectedRequest = QrRequest(memberId: 'member123', nonce: 'nonce456');
      when(mockRepository.sendQr(expectedRequest))
          .thenAnswer((_) async => QrResponse(status: 400, message: 'Error'));

      await viewModel.handleQrScan('member123', 'nonce456');

      expect(viewModel.status, QrScanStatus.ERROR);
      expect(viewModel.message, 'Error');
    });

    test('handleQrScan sets status to ERROR on exception', () async {
      final expectedRequest = QrRequest(memberId: 'member123', nonce: 'nonce456');
      when(mockRepository.sendQr(expectedRequest))
          .thenThrow('Network error');

      await viewModel.handleQrScan('member123', 'nonce456');

      expect(viewModel.status, QrScanStatus.ERROR);
      expect(viewModel.message, 'Network error');
    });

    test('reset clears status and message', () {
      viewModel.reset();

      expect(viewModel.status, isNull);
      expect(viewModel.message, isNull);
    });
  });
}