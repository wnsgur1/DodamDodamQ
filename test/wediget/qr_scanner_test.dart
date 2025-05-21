import 'package:dodamdodam_q/ui/widget/qr_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('QrScanner 위젯 생성 테스트', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: QrScanner(
            onScan: (code) {},
          ),
        ),
      ),
    );

    expect(find.byType(QrScanner), findsOneWidget);
  });
}
