import 'package:flutter_bmi_calculator/app/app.dart';
import 'package:flutter_bmi_calculator/bmi_calculator/bmi_calculator.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(BmiCalculatorPage), findsOneWidget);
    });
  });
}
