import 'package:cool_stepper/cool_stepper.dart';
import 'package:flutter/material.dart';
import 'package:goplus/dashboard.dart';
import 'package:goplus/services/formulaireRequest.dart';
import 'package:goplus/utils/app_colors.dart';
import 'package:goplus/widget/backButton.dart';
import 'package:goplus/widget/buildTextField.dart';
import 'package:goplus/widget/cool_steper.dart';
import 'package:goplus/widget/notification_dialog.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

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
  String? pays = '';
  late String key;

  DateTime? selectedDate;
  String? selectedHoure;
  bool showDate = false;

  Future<DateTime> _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
    return selectedDate!;
  }

  String getDate() {
    // ignore: unnecessary_null_comparison
    if (selectedDate == null) {
      return '';
    } else {
      return DateFormat('d-M-yyyy').format(selectedDate!);
    }
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController prenomController = TextEditingController();
  TextEditingController naissanceController = TextEditingController();
  TextEditingController adresseController = TextEditingController();
  TextEditingController villeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    key = widget.datas['key'];

    List form1 = [
      {
        'labelText': 'Nom',
        'validator': 'Le nom est requis',
        'controller': nameController,
        'keyboardType': TextInputType.name
      },

      {
        'labelText': 'Post-Nom',
        'validator': 'Le post-nom est requis',
        'controller': lastNameController,
        'keyboardType': TextInputType.name
      },

      {
        'labelText': 'Prénom',
        'validator': 'Le prénom est requis',
        'controller': prenomController,
        'keyboardType': TextInputType.name
      },

      {
        'labelText': 'Date de naissance (J/M/AAAA)',
        'validator': 'La date de naissance est requise',
        'controller': naissanceController,
        'keyboardType': TextInputType.datetime
      },

      {
        'labelText': 'Adresse Physique',
        'validator': 'L\'adresse physique est requise',
        'controller': adresseController,
        'keyboardType': TextInputType.text
      },

      {
        'labelText': 'Ville',
        'validator': 'La ville est requise',
        'controller': villeController,
        'keyboardType': TextInputType.name
      },

      {
        'labelText': 'Numéro de téléphone',
        'validator': 'Le numéro de téléphone est requis',
        'controller': phoneController,
        'keyboardType': TextInputType.phone
      },

      {
        'labelText': 'Adresse Email',
        'validator': 'L\'adresse email est requise',
        'controller': emailController,
        'keyboardType': TextInputType.emailAddress
      }
    ];

    List item = widget.datas['country'];
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
          if(pays! == ''){
            notification_dialog(
                context,
                'Selectionner un pays.',
                Icons.error,
                Colors.red,
                {'label': 'FERMER', 'onTap': ()=>Navigator.pop(context)},
              20,
              false
            );
            return 'ok ';
          }
          return null;
        },
      ),

      CoolStep(
        title: widget.datas['subtitle'] != widget.datas['subtitle'] ?
          '${widget.datas['subtitle']} - ${widget.datas['title']}'
            : '${widget.datas['subtitle']}',
        subtitle: 'Entrez vos coordonnées',
        content: Form(
            key: _formKey,
            child: Column(
              children: form1.map((e) => BuildTextField(
                labelText: '${e['labelText']}',
                keyboardType: e['keyboardType'],
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
          if (!_formKey.currentState!.validate()) {
            notification_dialog(
                context,
                'Completez le formulaire.',
                Icons.error,
                Colors.red,
                {'label': 'FERMER', 'onTap': ()=>Navigator.pop(context)},
                20,
              false
            );
            return 'Fill form correctly';
          }
          return null;
        },
      ),

      CoolStep(
        title: widget.datas['subtitle'] != widget.datas['subtitle'] ?
        '${widget.datas['subtitle']} - ${widget.datas['title']}'
            : '${widget.datas['subtitle']}',
        subtitle: 'Choissisez une date de rendez-vous',
        content: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              width: double.infinity,
              child: GestureDetector(
                onTap: () {
                  _selectDate(context);
                  showDate = true;
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
                          'CHOISIR UNE DATE'
                      ),
                    )
                )
              ),
            ),

            showDate ? Center(
                child: Text('Vous avez choisi le : ${getDate()}'
                )) : const SizedBox(),
          ],
        ),
        validation: () {
          if(!showDate){
            notification_dialog(
                context,
                'Selectionner une date de rendez-vous..',
                Icons.error,
                Colors.red,
                {'label': 'FERMER',
                  'onTap': ()=>Navigator.pop(context)
                },
              20,
              false
            );
            return 'Select date';
          }
        return null;
      },
      ),

      CoolStep(
        title: widget.datas['subtitle'] != widget.datas['subtitle'] ?
        '${widget.datas['subtitle']} - ${widget.datas['title']}'
            : '${widget.datas['subtitle']}',
        subtitle: 'Choissisez une heure de rendez-vous',
        content: Column(
          children: [
            _buildHour(
              context: context,
              name: '09h00',
            ),
            SizedBox(height: 16.0),
            _buildHour(
              context: context,
              name: '10h00',
            ),
            SizedBox(height: 16.0),
            _buildHour(
              context: context,
              name: '11h00',
            ),
            SizedBox(height: 16.0),
            _buildHour(
              context: context,
              name: '12h00',
            ),
            SizedBox(height: 16.0),
            _buildHour(
              context: context,
              name: '13h00',
            ),
            SizedBox(height: 16.0),
            _buildHour(
              context: context,
              name: '14h00',
            ),
            SizedBox(height: 16.0),
            _buildHour(
              context: context,
              name: '15h00',
            ),
            SizedBox(height: 16.0),
            _buildHour(
              context: context,
              name: '16h00',
            ),
            SizedBox(height: 16.0),
            _buildHour(
              context: context,
              name: '17h00',
            ),
          ],
        ),
        validation: () {
          if(selectedHoure == null){
            notification_dialog(
                context,
                'Selectionner une heure de rendez-vous..',
                Icons.error,
                Colors.red,
                {'label': 'FERMER',
                  'onTap': ()=>Navigator.pop(context)
                },
              20,
              false
            );
            return 'erreur';
          }
          return null;
      },
      ),

      CoolStep(
        title: widget.datas['subtitle'] != widget.datas['subtitle'] ?
        '${widget.datas['subtitle']} - ${widget.datas['title']}'
            : '${widget.datas['subtitle']}',
        subtitle: 'Validation du formulaire',
        content: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          width: double.infinity,
          child: GestureDetector(
              onTap: () {
                var data = {
                  "key": widget.datas['key'],
                  "cname": pays!,
                  "lastn": nameController.text.trim(),
                  "midn": lastNameController.text.trim(),
                  "firstn": prenomController.text.trim(),
                  "birthdate": naissanceController.text.trim(),
                  "address": adresseController.text.trim(),
                  "city": villeController.text.trim(),
                  "phone": phoneController.text.trim(),
                  "email": emailController.text.trim(),
                  "rdvdate": getDate(),
                  "hour": selectedHoure
                };

                Provider.of<Datas>(context, listen: false).formulaire(context, data);

                // notification_dialog(context,
                //     'Votre rendez-vous a été prise.',
                //     Icons.check_circle,
                //     Colors.green,
                //   {
                //     'label' : 'FERMER',
                //     'onTap' : (){
                //       Navigator.pushAndRemoveUntil(context,
                //           MaterialPageRoute(
                //               builder: (context)=> Dashboard()
                //           ), (route) => false);
                //     }
                //
                //   }
                // );
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
                        'CONFIRMATION DU RENDEZ-VOUS'
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

  Widget _buildHour({
    BuildContext? context,
    required String name,
  }) {
    final isActive = name == selectedHoure;

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
          groupValue: selectedHoure,
          onChanged: (String? v) {
            setState(() {
              selectedHoure = v!;
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