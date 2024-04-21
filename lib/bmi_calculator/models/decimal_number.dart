import 'package:formz/formz.dart';

enum NumberValidationError {
  empty,
  notANumber,
}

class DecimalNumber extends FormzInput<double, NumberValidationError> {
  const DecimalNumber.pure() : super.pure(0);

  DecimalNumber.dirty([String value = '0'])
      : super.dirty(double.tryParse(value) ?? 0);

  @override
  NumberValidationError? validator(double? value) {
    return value == 0
        ? NumberValidationError.empty
        : value != null
            ? null
            : NumberValidationError.notANumber;
  }
}
