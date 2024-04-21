part of 'bmi_calculator_cubit.dart';

enum BmiResult {
  notCalculated,
  underWeight,
  normalWeight,
  overWeight,
  obese,
}

class BmiCalculatorState extends Equatable {
  const BmiCalculatorState({
    this.height = const DecimalNumber.pure(),
    this.weight = const DecimalNumber.pure(),
    this.isValid = false,
    this.isCalculated = false,
    this.result = BmiResult.notCalculated,
    this.bmi,
  });

  final DecimalNumber height;
  final DecimalNumber weight;
  final bool isValid;
  final bool isCalculated;
  final double? bmi;
  final BmiResult result;

  BmiCalculatorState copyWith({
    DecimalNumber? height,
    DecimalNumber? weight,
    bool? isValid,
    bool? isCalculated,
    double? bmi,
    BmiResult? result,
  }) =>
      BmiCalculatorState(
        height: height ?? this.height,
        weight: weight ?? this.weight,
        isValid: isValid ?? this.isValid,
        isCalculated: isCalculated ?? this.isCalculated,
        result: result ?? this.result,
        bmi: bmi ?? this.bmi,
      );

  @override
  List<Object?> get props => [
        height,
        weight,
        isValid,
        isCalculated,
        bmi,
        result,
      ];
}
