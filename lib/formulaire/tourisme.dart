import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/material.dart';
import 'package:goplus/widget/backButton.dart';
import 'package:goplus/widget/buildTextField.dart';
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

  List form1 = [
    {
      'labelText': 'Nom',
      'validator': 'Le nom est requis',
      'controller': null,
    }
  ];

  @override
  Widget build(BuildContext context) {

    final steps = [
      CoolStep(
          title: 'Voyage de Rêve - Tourisme',
          subtitle: 'Choissisez votre pays de rêve',
          content: Column(
            children: [
              _buildSelector(
                context: context,
                name: 'CANADA',
              ),
              SizedBox(height: 16.0),
              _buildSelector(
                context: context,
                name: 'DUBAI',
              ),
              SizedBox(height: 16.0),
              _buildSelector(
                context: context,
                name: 'ESPAGNE',
              ),
              SizedBox(height: 16.0),
              _buildSelector(
                context: context,
                name: 'FRANCE',
              ),
              SizedBox(height: 16.0),
              _buildSelector(
                context: context,
                name: 'TURQUIE',
              ),
            ],
          ), validation: () {
              return null;
            },
      ),

      CoolStep(
        title: 'Voyage de Rêve - Tourisme',
        subtitle: 'Entrez vos coordonnées',
        content: Form(
            key: _formKey,
            child: Column(
              children: form1.map((e) => BuildTextField(
                labelText: '${e['labelText']}',
                validator: (value) {
                  if (value!.isEmpty) {
                    return '${e['validator']}';
                  }
                  return null;
                }, context: context,
                controller: e['controller'],
              )).toList(),
            )
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

  Widget _buildSelector({
    BuildContext? context,
    required String name,
  }) {
    final isActive = name == pays;

    return Container(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isActive ? Colors.black : null,
          border: Border.all(
            width: 0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: RadioListTile(
          value: name,
          activeColor: Colors.white,
          groupValue: pays,
          onChanged: (String? v) {
            setState(() {
              pays = v;
            });
          },
          title: Text(
            name,
            style: TextStyle(
              color: isActive ? Colors.white : null,
            ),
          ),
        ),
      ),
    );
  }
}