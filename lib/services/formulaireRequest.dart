import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart' as Dio;
import '../dashboard.dart';
import '../widget/notification_dialog.dart';
import 'dio.dart';

class Datas extends ChangeNotifier{

  void formulaire(BuildContext context, var data) async {
    try{
      Dio.Response response = await dio()!.post('/v1/', data: jsonEncode(data));
      Map<String, dynamic> dats = jsonDecode(response.data);

      notification_dialog(context,
          '${dats['message']}',
          Icons.check_circle,
          Colors.green,
        {
          'label' : 'FERMER',
          'onTap' : (){
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(
                    builder: (context)=> Dashboard()
                ), (route) => false);
          }

        },
        15,
        false
      );
      notifyListeners();
    } catch(e){
      print('Paille ${e}');
    }
  }

// void categorie() async {
//   try {
//     Dio.Response response = await dio()!.get('/homedata');
//     Iterable datas = jsonDecode(response.data);
//     // List<Categorie>? cat = List<Categorie>.from(datas.map((model)=> Categorie.fromJson(model)));
//     // _categories = cat;
//     print('${datas}');
//     notifyListeners();
//   } catch (e){
//     print(e);
//   }
// }

// void room() async {
//   try {
//     Dio.Response response = await dio()!.get('/rooms/all');
//     Iterable datas = jsonDecode(response.data);
//     List<Rooms>? rooms = List<Rooms>.from(datas.map((model)=> Rooms.fromJson(model)));
//     _rooms = rooms;
//     notifyListeners();
//   } catch (e){
//     print(e);
//   }
// }

// void recommandation() async {
//   try {
//     Dio.Response response = await dio()!.get('/rooms/recommandation');
//     Iterable datas = jsonDecode(response.data);
//     List<Rooms>? rooms = List<Rooms>.from(datas.map((model)=> Rooms.fromJson(model)));
//     _rooms = rooms;
//     notifyListeners();
//   } catch (e){
//     print(e);
//   }
// }

// void roomNoted() async {
//   try {
//     Dio.Response response = await dio()!.get('/rooms/noted');
//     Iterable datas = jsonDecode(response.data);
//     List<Rooms>? rooms = List<Rooms>.from(datas.map((model)=> Rooms.fromJson(model)));
//     _noted = rooms;
//     notifyListeners();
//   } catch (e){
//     print(e);
//   }
// }

// void reservation ({required Map creds, required BuildContext context}) async {
//
//   try {
//     Dio.Response response = await dio()!.post('/rooms/reservation', data: creds);
//     if(response.statusCode == 200){
//       var res = jsonDecode(response.data);
//       if(res['code'] == 1){
//         showAlertDialog(context, 'Reservation', '${res['data'].toString()}');
//       } else {
//         showAlertDialog(context, 'Reservation', '${res['data'].toString()}');
//       }
//     }
//   } catch (e){
//     showAlertDialog(context, 'Reservation', '${e.toString()}');
//   }
// }
}