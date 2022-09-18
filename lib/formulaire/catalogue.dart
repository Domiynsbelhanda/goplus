import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/material.dart';
import 'package:goplus/dashboard.dart';
import 'package:goplus/gofly/utils/app_colors.dart';
import 'package:goplus/gofly/widgets/app_widgets/app_button.dart';
import 'package:goplus/widget/backButton.dart';
import 'package:goplus/widget/buildTextField.dart';
import 'package:goplus/widget/cool_steper.dart';
import 'package:goplus/widget/notification_dialog.dart';
import 'package:intl/intl.dart';

class CatalogueForm extends StatefulWidget{
  var datas;
  CatalogueForm(this.datas, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CatalogueForm();
  }
}

class _CatalogueForm extends State<CatalogueForm>{

  final _formKey = GlobalKey<FormState>();
  String? pays = '';

  DateTime selectedDate = DateTime.now();
  bool showDate = false;

  Future<DateTime> _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
    return selectedDate;
  }

  String getDate() {
    // ignore: unnecessary_null_comparison
    if (selectedDate == null) {
      return 'select date';
    } else {
      return DateFormat('d-M-yyyy').format(selectedDate);
    }
  }

  List form1 = [
    {
      'labelText': 'Nom',
      'validator': 'Le nom est requis',
      'controller': null,
      'keyboardType': TextInputType.name
    },

    {
      'labelText': 'Post-Nom',
      'validator': 'Le post-nom est requis',
      'controller': null,
      'keyboardType': TextInputType.name
    },

    {
      'labelText': 'Prénom',
      'validator': 'Le prénom est requis',
      'controller': null,
      'keyboardType': TextInputType.name
    },

    {
      'labelText': 'Date de naissance (J/M/AAAA)',
      'validator': 'La date de naissance est requise',
      'controller': null,
      'keyboardType': TextInputType.datetime
    },

    {
      'labelText': 'Adresse Physique',
      'validator': 'Le post-nom est requis',
      'controller': null,
      'keyboardType': TextInputType.text
    },

    {
      'labelText': 'Ville',
      'validator': 'La ville est requise',
      'controller': null,
      'keyboardType': TextInputType.name
    },

    {
      'labelText': 'Numéro de téléphone',
      'validator': 'Le numéro de téléphone est requis',
      'controller': null,
      'keyboardType': TextInputType.phone
    },

    {
      'labelText': 'Adresse Email',
      'validator': 'L\'adresse email est requise',
      'controller': null,
      'keyboardType': TextInputType.emailAddress
    }
  ];

  @override
  Widget build(BuildContext context) {
    List item = widget.datas['country'];
    List format = widget.datas['format'];
    final steps = [
      CoolStep(
        title: widget.datas['subtitle'] != widget.datas['subtitle'] ?
        '${widget.datas['subtitle']} - ${widget.datas['title']}'
            : '${widget.datas['subtitle']}',
          subtitle: 'Choissisez votre pays de rêve',
          content: Column(
            children: item
                .map((e)=>
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: _buildSelector(
                    context: context,
                    name: '${e}',
                  ),
                ),
            ).toList(),
          ),
            validation: () {
              return null;
            },
      ),

      CoolStep(
        title: widget.datas['subtitle'] != widget.datas['subtitle'] ?
        '${widget.datas['subtitle']} - ${widget.datas['title']}'
            : '${widget.datas['subtitle']}',
        subtitle: 'Choissisez votre pays de rêve',
        content: Column(
          children: format
              .map((e)=>
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: _buildSelector(
                  context: context,
                  name: '${e}',
                ),
              ),
          ).toList(),
        ),
        validation: () {
          return null;
        },
      ),

      CoolStep(
        title: '${widget.datas['subtitle']} - ${widget.datas['title']}',
        subtitle: 'Telechargez au format.',
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          width: double.infinity,
          child: GestureDetector(
              onTap: () {
                notification_dialog(context,
                    'TELECHARGEMENT EN COURS...',
                  {
                    'label' : 'FERMER',
                    'onTap' : (){
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(
                              builder: (context)=> Dashboard()
                          ), (route) => false);
                    }

                  }
                );
              },
              child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        borderRadius: BorderRadius.circular(8.0)
                    ),
                    margin: const EdgeInsets.all(16.0),
                    padding: const EdgeInsets.all(16.0),
                    child: const Text(
                        'TELECHARGER'
                    ),
                  )
              )
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
                child: CloseButtons(context)
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