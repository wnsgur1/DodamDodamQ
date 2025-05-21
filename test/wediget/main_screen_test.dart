import 'package:dodamdodam_q/ui/widget/qr_scanner.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:dodamdodam_q/ui/screen/main_screen.dart';
import 'package:dodamdodam_q/ui/view_model/main_view_model.dart';
import 'package:dodamdodam_q/data/repository/qr_repository.dart';

class MockQrRepository extends Mock implements QrRepository {}

void main() {
  testWidgets('MainScreen renders correctly', (WidgetTester tester) async {
    final mockRepository = MockQrRepository();

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => MainViewModel(mockRepository),
          child: const MainScreen(),
        ),
      ),
    );

    expect(find.text('QR 스캔'), findsOneWidget);
    expect(find.byType(QrScanner), findsOneWidget);
  });
}