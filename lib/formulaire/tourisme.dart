import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/material.dart';
import 'package:goplus/widget/backButton.dart';
import 'package:goplus/widget/cool_steper.dart';

class TourismForm extends StatefulWidget{
  var datas;
  TourismForm(this.datas, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TourismForm();
  }
}

class _TourismForm extends State<TourismForm>{

  final _formKey = GlobalKey<FormState>();
  String? pays = 'Canada';

  @override
  Widget build(BuildContext context) {

    final steps = [
      CoolStep(
          title: 'Voyage de Rêve - Tourisme',
          subtitle: 'Choissisez votre pays de rêve',
          content: Form(
            key: _formKey,
            child: Column(
              children: [

              ],
            ),
          ), validation: () {
              return null;
            },
      ),

      CoolStep(
        title: 'Voyage de Rêve - Tourisme',
        subtitle: 'Entrez vos coordonnées',
        content: Container(
          child: Row(
            children: [
            ],
          ),
        ),
        validation: () {
          return null;
        },
      ),
    ];

    final stepper = CoolSteppers(
      steps: steps,
      onCompleted: (){print('Belhanda');},
    );

    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            Container(
                child: stepper
            ),
            Positioned(
                top: 16,
                right: 16,
                child: BackButtons(context)
            ),
          ],
        ),
      ),
    );
  }
}