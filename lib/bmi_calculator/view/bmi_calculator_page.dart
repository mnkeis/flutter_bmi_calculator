import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bmi_calculator/bmi_calculator/bmi_calculator.dart';
import 'package:flutter_bmi_calculator/l10n/l10n.dart';

class BmiCalculatorPage extends StatelessWidget {
  const BmiCalculatorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BmiCalculatorCubit(),
      child: const BmiCalculatorView(),
    );
  }
}

class BmiCalculatorView extends StatelessWidget {
  const BmiCalculatorView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.bmiCalculatorAppBarTitle)),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: BlocBuilder<BmiCalculatorCubit, BmiCalculatorState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: l10n.bmiCalculatorHeightInputHint,
                    border: const OutlineInputBorder(),
                    errorText: state.height.isPure
                        ? null
                        : state.height.isNotValid
                            ? l10n.bmiCalculatorInvalidDecimal
                            : null,
                  ),
                  onChanged: context.read<BmiCalculatorCubit>().heightEdited,
                ),
                const SizedBox(height: 20),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    labelText: l10n.bmiCalculatorWeightInputHint,
                    border: const OutlineInputBorder(),
                    errorText: state.weight.isPure
                        ? null
                        : state.weight.isNotValid
                            ? l10n.bmiCalculatorInvalidDecimal
                            : null,
                  ),
                  onChanged: context.read<BmiCalculatorCubit>().weightEdited,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: state.isValid
                      ? () {
                          context.read<BmiCalculatorCubit>().calculateBmi();
                          FocusScope.of(context).unfocus();
                        }
                      : null,
                  child: Text(l10n.bmiCalculatorCalculateButtonLabel),
                ),
                const SizedBox(height: 20),
                if (state.isCalculated) ...[
                  Text(
                    '''${l10n.bmiCalculatorResultLabel} ${state.bmi?.toStringAsFixed(2)}''',
                    style: const TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  Builder(
                    builder: (context) {
                      late String result;
                      late Color color;
                      switch (state.result) {
                        case BmiResult.notCalculated:
                          result = '';
                          color = Colors.white;
                        case BmiResult.underWeight:
                          result = l10n.bmiCalculatorResultUnderWeight;
                          color = Colors.blue;
                        case BmiResult.normalWeight:
                          result = l10n.bmiCalculatorResultNormalWeight;
                          color = Colors.green;
                        case BmiResult.overWeight:
                          result = l10n.bmiCalculatorResultOverWeight;
                          color = Colors.red;
                        case BmiResult.obese:
                          result = l10n.bmiCalculatorResultObese;
                          color = Colors.red;
                      }
                      return Text(
                        result,
                        style: TextStyle(
                          fontSize: 20,
                          color: color,
                        ),
                      );
                    },
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}
