import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_bmi_calculator/bmi_calculator/bmi_calculator.dart';
import 'package:flutter_bmi_calculator/bmi_calculator/models/models.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('BmiCalculatorCubit', () {
    test('initial state is BmiCalculatorState', () {
      expect(BmiCalculatorCubit().state, equals(const BmiCalculatorState()));
    });

    group('heightEdited', () {
      blocTest<BmiCalculatorCubit, BmiCalculatorState>(
        'emits valid height when is called with a valid String',
        build: BmiCalculatorCubit.new,
        act: (cubit) => cubit.heightEdited('1.81'),
        expect: () => [BmiCalculatorState(height: DecimalNumber.dirty('1.81'))],
      );

      blocTest<BmiCalculatorCubit, BmiCalculatorState>(
        'emits invalid height when is called with a invalid String',
        build: BmiCalculatorCubit.new,
        act: (cubit) => cubit.heightEdited('a1.6'),
        expect: () => [BmiCalculatorState(height: DecimalNumber.dirty('a'))],
      );
    });

    group('weightEdited', () {
      blocTest<BmiCalculatorCubit, BmiCalculatorState>(
        'emits valid weight when is called with a valid String',
        build: BmiCalculatorCubit.new,
        act: (cubit) => cubit.weightEdited('81'),
        expect: () => [BmiCalculatorState(weight: DecimalNumber.dirty('81'))],
      );

      blocTest<BmiCalculatorCubit, BmiCalculatorState>(
        'emits invalid weight when is called with a invalid String',
        build: BmiCalculatorCubit.new,
        act: (cubit) => cubit.weightEdited('a6'),
        expect: () => [BmiCalculatorState(weight: DecimalNumber.dirty('a'))],
      );
    });

    group('calculateBmi', () {
      blocTest<BmiCalculatorCubit, BmiCalculatorState>(
        'calculates bmi correctly',
        build: BmiCalculatorCubit.new,
        seed: () => BmiCalculatorState(
          height: DecimalNumber.dirty('1.81'),
          weight: DecimalNumber.dirty('83'),
        ),
        act: (cubit) => cubit.calculateBmi(),
        expect: () => [
          BmiCalculatorState(
            height: DecimalNumber.dirty('1.81'),
            weight: DecimalNumber.dirty('83'),
            bmi: 25.33500198406642,
            isCalculated: true,
            result: BmiResult.overWeight,
          ),
        ],
      );
    });
  });
}
