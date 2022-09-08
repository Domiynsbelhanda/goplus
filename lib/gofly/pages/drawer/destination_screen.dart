import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:goplus/gofly/models/locales_models.dart';
import 'package:goplus/gofly/models/locales_provider_model.dart';
import 'package:goplus/gofly/pages/set_pickup_time_screen.dart';
import 'package:goplus/gofly/utils/strings.dart';
import 'package:goplus/gofly/widgets/kf_drawer.dart';
import 'package:goplus/gofly/widgets/map_widget.dart';

import '../../widgets/card_dashboard_item_place.dart';

class DestinationScreen extends KFDrawerContent {
  @override
  _DestinationScreenState createState() => _DestinationScreenState();
}

class _DestinationScreenState extends State<DestinationScreen> {
  late Size size;
  late DestinationModel _localeText;
  late List itemSeller;

  @override
  void initState() {
    super.initState();
    _localeText = Provider.of<LocalesProviderModel>(context, listen: false)
        .getLocalizedStrings
        .destinationScreen!;
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    itemSeller = [
      {
        'imagePath' : 'https://zoom-eco.net/wp-content/uploads/2019/12/IMG_20191214_092058.jpg',
        'title': 'Congo Airways',
        'description': 'A 20 Min',
        'onTap': ()=>print('belhanda')
      },

      {
        'imagePath' : 'https://cdn.uc.assets.prezly.com/83477061-4765-40db-97df-dc2cbd6c30da/-/resize/1108x/-/quality/best/-/format/auto/',
        'title': 'Bruxelles Airlines',
        'description': 'A 20 Min',
        'onTap': ()=>print('belhanda')
      },

      {
        'imagePath' : 'https://newsaero.info/news/admin/assets/image/actualite/actualite3618.jpg',
        'title': 'SA Airlines',
        'description': 'A 20 Min',
        'onTap': ()=>print('belhanda')
      },

      {
        'imagePath' : 'https://www.tourmag.com/photo/art/default/53441096-40459454.jpg?v=1611779069',
        'title': 'Ethipian Airways',
        'description': 'A 20 Min',
        'onTap': ()=>print('belhanda')
      },

      {
        'imagePath' : 'https://www.financialafrik.com/wp-content/uploads/2020/09/kenya-airways-600x311.jpg',
        'title': 'Kenya Airways',
        'description': 'A 20 Min',
        'onTap': ()=>print('belhanda')
      }
    ];
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              /// [Map]
              MapWidget(),

              ///[AppBar]
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 25,
                      width: 25,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: Colors.white),
                      child: IconButton(
                          padding: EdgeInsets.zero,
                          constraints: BoxConstraints(),
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size: 20,
                          ),
                          onPressed: widget.onMenuPressed),
                    ),
                    GestureDetector(
                      onTap: widget.onMenuPressed,
                      child: Container(
                        height: 35,
                        width: 40,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white),
                        child: SvgPicture.asset(StringValue.MENU),
                      ),
                    )
                  ],
                ),
              ),

              /// [my location button]
              Container(
                margin: EdgeInsets.only(
                    top: size.height * 0.5, left: size.width * 0.85),
                height: size.width * 0.15,
                width: size.width * 0.15,
                color: Colors.white,
                child: const Icon(
                  Icons.my_location,
                  size: 32.0,
                ),
              ),

              /// [Where are you going ?]
              Positioned(
                bottom: 0,
                child: Container(
                  width: size.width,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0, top: 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _localeText.whereGoing,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22.0,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(
                            _localeText.bodyWhereGoing,
                            style:
                                TextStyle(color: Colors.grey, fontSize: 16.0),
                          ),
                        ),
                        SizedBox(height: 10.0),
                        Container(
                          margin:
                              EdgeInsets.only(bottom: 20, top: 20, right: 20),
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 10)
                              ]),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: _localeText.enterDestination,
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                icon: Icon(Icons.search),
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => SetPickupTimeScreen(),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16,),

                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: itemSeller.map((e) => Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: CardPicturePlace(
                                imagePath: '${e['imagePath']}',
                                title: '${e['title']}',
                                description: '${e['description']}',
                                onTap: e['onTap'],
                              ),
                            )).toList(),
                          ),
                        ),

                        SizedBox(height: 20.0),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
