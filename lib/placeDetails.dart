import 'package:flutter/material.dart';
import 'package:goplus/gofly/pages/select_car_screen.dart';
import 'package:goplus/gofly/widgets/app_widgets/app_button.dart';

class PlaceDetailScreen extends StatefulWidget{

  PlaceDetailScreen(this.place);

  final place;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PlaceDetailScreen();
  }
}

class _PlaceDetailScreen extends State<PlaceDetailScreen>{

  late Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
      body: Container(
        height: size.height,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: size.height / 1.18,
                padding: EdgeInsets.all(10.0),
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16.0)),
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          '${this.widget.place['imagePath']}'
                      )
                  ),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                height: size.height / 1.18,
                padding: EdgeInsets.all(10.0),
                width: size.width,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    gradient: LinearGradient(
                        begin: FractionalOffset.topCenter,
                        end: FractionalOffset.bottomCenter,
                        colors: [
                          Colors.grey.withOpacity(0.0),
                          Colors.black.withOpacity(.5),
                        ],
                        stops: [
                          0.0,
                          1.0
                        ]
                    )
                ),
              ),
            ),

            const Positioned(
              top: 32,
              left: 32,
              child: BackButton()
            ),

            Positioned(
              bottom: size.height - ((size.height / 1.18)),
                left: 32,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${this.widget.place['title']}',
                        style: TextStyle(
                            fontSize: size.width / 15,
                            color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),

                      SizedBox(height: 4.0,),

                      Text(
                        '${this.widget.place['description']}',
                        style: TextStyle(
                          fontSize: size.width / 20,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                )
            ),

            Positioned(
              bottom: 16.0,
              child: Container(
                width: size.width,
                child: AppButton(
                  name: 'RESERVER',
                  onTap: (){
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SelectCarScreen())
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}