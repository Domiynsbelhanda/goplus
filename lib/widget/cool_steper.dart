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
      onCompleted: ()=>onCompleted,
      steps: steps,
      config: const CoolStepperConfig(
          backText: 'PRECEDENT',
          nextText: 'SUIVANT',
          stepText: 'ETAPE',
          ofText: 'SUR',
          finalText: 'FIN'
      ),
    );
  }
}