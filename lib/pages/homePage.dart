import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:goplus/pages/BodyPage.dart';
import 'package:goplus/widget/app_button.dart';
import 'package:kf_drawer/kf_drawer.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';
import '../main.dart';
import '../services/auth.dart';
import '../utils/class_builder.dart';
import '../utils/global_variable.dart';
import '../utils/app_colors.dart';
import 'AboutPage.dart';
import 'HistoryPage.dart';
import 'google_maps_popylines.dart';

class HomePage extends StatefulWidget{
  HomePage({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePage();
  }
}

class _HomePage extends State<HomePage> with TickerProviderStateMixin{

  late KFDrawerController _drawerController;
  late Size size;

  void requestPermission() async{
    Map<Permission, PermissionStatus> request =  await [
      Permission.location
    ].request();
  }


  @override
  void initState() {
    super.initState();
    _drawerController = KFDrawerController(
      initialPage: ClassBuilder.fromString('BodyPage'),
      items: [
        KFDrawerItem.initWithPage(
          text: const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
                'Accueil',
                style: TextStyle(
                    color: Colors.white,
                  fontSize: 24.0
                )
            ),
          ),
          icon: const Padding(
            padding: EdgeInsets.only(bottom : 16.0, left: 8.0),
            child: Icon(
                Icons.home,
                color: Colors.white,
              size: 24.0,
            ),
          ),
          page: BodyPage(),
        ),

        KFDrawerItem.initWithPage(
          text: const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
                'Mes courses',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24
                )
            ),
          ),
          icon: const Padding(
            padding: EdgeInsets.only(bottom : 16.0, left: 8.0),
            child: Icon(
              Icons.list_alt,
              color: Colors.white,
              size: 24,
            ),
          ),
          page: HistoryPage(),
        ),

        KFDrawerItem.initWithPage(
          text: const Padding(
            padding: EdgeInsets.only(bottom: 16.0),
            child: Text(
                'A Propos',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.0
                )
            ),
          ),
          icon: const Padding(
            padding: EdgeInsets.only(bottom : 16.0, left: 8.0),
            child: Icon(
              Icons.settings,
              color: Colors.white,
              size: 24.0,
            ),
          ),
          page: AboutPage(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    ToastContext().init(context);
    readBitconMarkerPinner();
    return Scaffold(
      body: FutureBuilder<String?>(
        future: Provider.of<Auth>(context, listen: false).getToken(),
        builder: (context, yourToken) {
          if(yourToken.hasData){
            token = yourToken.data;
            return StreamBuilder(
                stream: FirebaseFirestore.instance.collection("clients").doc(yourToken.data!).snapshots(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> yourCourses) {
                  if(yourCourses.hasData){
                    Map<String, dynamic> donn = yourCourses.data!.data() as Map<String, dynamic>;
                    if(donn['uuid'] != null){
                      disableLoader();
                      return StreamBuilder(
                        stream: FirebaseFirestore.instance.collection("courses").doc(donn['uuid']).snapshots(),
                        builder: (context, AsyncSnapshot<DocumentSnapshot> coursesSnap){
                          if(coursesSnap.hasData){
                            Map<String, dynamic> dataCourses = coursesSnap.data!.data() as Map<String, dynamic>;
                            if(dataCourses['status']=='confirm' || dataCourses['status']=='start' || dataCourses['status']=='end'){
                              return GoogleMapsPolylines(
                                  data: dataCourses,
                                  uuid: donn['uuid']
                              );
                            }
                            return BodyContent();
                          }
                          return Center(
                            child: SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: const [
                                  CircularProgressIndicator(
                                    color: AppColors.primaryColor,
                                  ),

                                  SizedBox(height: 16.0,),

                                  const Text('Chargement...'),
                                ],
                              ),
                            ),
                          );
                        }
                      );
                    }
                  }
                  return FutureBuilder<bool>(
                      future: Permission.location.serviceStatus.isEnabled,
                      builder: (context, snapshot) {
                        if(snapshot.hasData){
                          if(snapshot.data!){
                            return FutureBuilder<PermissionStatus>(
                                future: Permission.location.status,
                                builder: (context, status){
                                  if(status.hasData){
                                    if(status.data!.isGranted){
                                      return FutureBuilder<Position>(
                                        future: Geolocator.getCurrentPosition(),
                                        builder: (context, location){
                                          disableLoader();
                                          if(location.hasData){
                                            disableLoader();
                                            position = LatLng(location.data!.latitude, location.data!.longitude);
                                            return BodyContent();
                                          } else {
                                            return Center(
                                              child: SizedBox(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: const [
                                                    CircularProgressIndicator(
                                                      color: AppColors.primaryColor,
                                                    ),

                                                    SizedBox(height: 16.0,),

                                                    Text('Chargement...'),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      );
                                    } else{
                                      disableLoader();
                                      requestPermission();
                                      return Center(
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              const Text(
                                                "Autorisé l'aplication à utiliser votre position. \nAllez dans les paramètres pour forcer l'autorisation.",
                                                textAlign: TextAlign.center,
                                              ),

                                              const SizedBox(height: 16.0,),

                                              AppButton(
                                                onTap: ()=>openAppSettings(),
                                                name: "Paramètre",
                                                color: AppColors.primaryColor,
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }
                                  } else {
                                    requestPermission();
                                    return Container();
                                  }
                                }
                            );
                          } else {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(
                                  "Activez la localisation puis relancer l'application pour utiliser GoPlus",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          }
                        } else {
                          return Container();
                        }
                      }
                  );
                }
            );
          }

          return const Center(
              child:
              Text('Veuillez patienter')
          );
        }
      ),
    );
  }

  Widget BodyContent(){
    return KFDrawer(
      borderRadius: 16.0,
      shadowBorderRadius: 16.0,
      menuPadding: const EdgeInsets.all(8.0),
      scrollable: true,
      controller: _drawerController,
      header: Align(
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 64.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            width: MediaQuery.of(context).size.width * 0.6,
            child: Image.asset(
              'assets/icon/white-text.png',
              alignment: Alignment.centerLeft,
            ),
          ),
        ),
      ),
      footer: KFDrawerItem(
        text: const Padding(
          padding: EdgeInsets.only(bottom: 16.0),
          child: Text(
              'Deconnexion',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.0
              )
          ),
        ),
        icon: const Padding(
          padding: EdgeInsets.only(bottom : 16.0, left: 8.0),
          child: Icon(
            Icons.logout,
            color: Colors.white,
            size: 24.0,
          ),
        ),
        onPressed: () {
          logOut();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => const MyApp()
              ),
                  (Route<dynamic> route) => false
          );
        },
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.orange, AppColors.primaryColor],
          tileMode: TileMode.repeated,
        ),
      ),
    );
  }
}