import 'package:dodamdodam_q/ui/screen/main_screen.dart';
import 'package:dodamdodam_q/ui/widget/qr_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('전체 앱 흐름 테스트', (WidgetTester tester) async {
    await tester.pumpWidget(const MainScreen());

    expect(find.text('QR 스캔'), findsOneWidget);

    expect(find.byType(QrScanner), findsOneWidget);

  });
}
