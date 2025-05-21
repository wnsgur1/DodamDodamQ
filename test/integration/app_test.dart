
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:dodamdodam_q/main.dart' as app;



void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('전체 앱 흐름 테스트', (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();

    // 테스트 코드 작성
  });
}