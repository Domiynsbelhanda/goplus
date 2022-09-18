import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/material.dart';

class CoolSteppers extends StatelessWidget{

  CoolSteppers({required this.steps, required this.onCompleted});

  final steps;
  final Function onCompleted;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return CoolStepper(
      showErrorSnackbar: false,
      onCompleted: () {
        print('Etape terminée!');
      },
      steps: steps,
      config: CoolStepperConfig(
          backText: 'PRECEDENT',
          nextText: 'SUIVANT',
          stepText: 'ETAPE',
          ofText: 'SUR'
      ),
    );
  }
}