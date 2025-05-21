import 'package:dodamdodam_q/ui/widget/dodam_topApp_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets('DodamTopAppBar 위젯 테스트', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: DodamTopAppBar(
            title: 'QR 스캔',
            description: 'QR코드는 버스좌석 선택시 확인할 수 있습니다.',
          ),
        ),
      ),
    );

    expect(find.text('QR 스캔'), findsOneWidget);
    expect(find.text('QR코드는 버스좌석 선택시 확인할 수 있습니다.'), findsOneWidget);
  });
}
