import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bmi_calculator/bmi_calculator/bmi_calculator.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/helpers.dart';

class MockCounterCubit extends MockCubit<BmiCalculatorState>
    implements BmiCalculatorCubit {}

void main() {
  group('BmiCalculatorPage', () {
    testWidgets('renders BmiCalculatorView', (tester) async {
      await tester.pumpApp(const BmiCalculatorPage());
      expect(find.byType(BmiCalculatorView), findsOneWidget);
    });
  });

  group('BmiCalculatorView', () {
    late BmiCalculatorCubit bmiCalculatorCubit;

    setUp(() {
      bmiCalculatorCubit = MockCounterCubit();
    });

    testWidgets('renders height and weight inputs', (tester) async {
      const state = BmiCalculatorState();
      when(() => bmiCalculatorCubit.state).thenReturn(state);
      await tester.pumpApp(
        BlocProvider.value(
          value: bmiCalculatorCubit,
          child: const BmiCalculatorView(),
        ),
      );
      expect(find.byType(TextField), findsExactly(2));
    });

    testWidgets('calculate button is enabled when isValid is true',
        (tester) async {
      when(() => bmiCalculatorCubit.state).thenReturn(
        const BmiCalculatorState(isValid: true),
      );
      when(() => bmiCalculatorCubit.calculateBmi()).thenReturn(null);
      await tester.pumpApp(
        BlocProvider.value(
          value: bmiCalculatorCubit,
          child: const BmiCalculatorView(),
        ),
      );
      await tester.tap(find.byType(ElevatedButton));
      verify(() => bmiCalculatorCubit.calculateBmi()).called(1);
    });

    testWidgets('calculate button is disabled when isValid is false',
        (tester) async {
      when(() => bmiCalculatorCubit.state).thenReturn(
        const BmiCalculatorState(),
      );
      when(() => bmiCalculatorCubit.calculateBmi()).thenReturn(null);
      await tester.pumpApp(
        BlocProvider.value(
          value: bmiCalculatorCubit,
          child: const BmiCalculatorView(),
        ),
      );
      await tester.tap(find.byType(ElevatedButton));
      verifyNever(() => bmiCalculatorCubit.calculateBmi());
    });
  });
}
