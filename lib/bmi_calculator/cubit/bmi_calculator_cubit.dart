import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bmi_calculator/bmi_calculator/models/models.dart';
import 'package:formz/formz.dart';

part 'bmi_calculator_state.dart';

class BmiCalculatorCubit extends Cubit<BmiCalculatorState> {
  BmiCalculatorCubit() : super(const BmiCalculatorState());

  void heightEdited(String? value) {
    if (value != null) {
      final height = DecimalNumber.dirty(value);
      emit(
        state.copyWith(
          height: height,
          isCalculated: false,
          isValid: Formz.validate([height, state.weight]),
        ),
      );
    }
  }

  void weightEdited(String? value) {
    if (value != null) {
      final weight = DecimalNumber.dirty(value);
      emit(
        state.copyWith(
          weight: weight,
          isCalculated: false,
          isValid: Formz.validate([weight, state.height]),
        ),
      );
    }
  }

  void calculateBmi() {
    final bmi = state.weight.value / (state.height.value * state.height.value);
    emit(
      state.copyWith(
        bmi: bmi,
        isCalculated: true,
        result: bmi < 18.5
            ? BmiResult.underWeight
            : (bmi < 24.9
                ? BmiResult.normalWeight
                : (bmi < 29.9 ? BmiResult.overWeight : BmiResult.obese)),
      ),
    );
  }
}
