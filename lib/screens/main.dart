import 'dart:convert';
import 'dart:io';

import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/custom/CommonFunctoins.dart';
import 'package:active_ecommerce_flutter/data_model/popupmodel.dart';
import 'package:active_ecommerce_flutter/my_theme.dart';
import 'package:active_ecommerce_flutter/providers/locale_provider.dart';
import 'package:active_ecommerce_flutter/repositories/popuprepo.dart';
import 'package:active_ecommerce_flutter/screens/cart.dart';
import 'package:active_ecommerce_flutter/screens/category_list.dart';
import 'package:active_ecommerce_flutter/screens/filter2.dart';
import 'package:active_ecommerce_flutter/screens/home.dart';
import 'package:active_ecommerce_flutter/screens/login.dart';
import 'package:active_ecommerce_flutter/screens/profile.dart';
import 'package:active_ecommerce_flutter/screens/filter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:platform/platform.dart';
import 'package:provider/provider.dart';

import 'filter3.dart';
import 'package:http/http.dart' as http;

class Main extends StatefulWidget {
  Main({Key key, go_back = true}) : super(key: key);

  bool go_back;

  @override
  _MainState createState() => _MainState();
}

class _MainState extends State<Main> {
  String popupimage;
  PopupModel popupData ;
  List<Datum> imageList=[];
   LocaleProvider localProvider;
   var imageLink;
   


bool initialPopup=true;
  int _currentIndex = 0;
  var _children = [
    Home(),
    CategoryList(
      is_base_category: true,
    ),
    Home(),
    Cart(has_bottomnav: true),
    // Profile()

    !is_logged_in.$ == true ? Login() : Profile()
  ];

  void onTapped(int i) {
    setState(() {
      _currentIndex = i;
    });
  }
  fatchPopupData()async{
 popupData = await Popuprepo().getdata() ;
 imageLink= popupData.data[0].value;

 localProvider.isPopUp = false;
 localProvider.setIsPopUp(localProvider.isPopUp );
    setState(() {
    
      // imageList=  popupData.data;
      
    });
    print('imgLink: $imageLink');
    print(initialPopup);
    imageLink ==""? ShowNothing():showDialog(
          context: context,
          builder: (context) => AlertDialog(
            content: Stack(
              alignment: Alignment.center,
              children: <Widget>[
              localProvider.isPopUp==true ?CircularProgressIndicator(color: Colors.blue,):
               Image.network(
                  // 'https://thumbs.dreamstime.com/b/environment-earth-day-hands-trees-growing-seedlings-bokeh-green-background-female-hand-holding-tree-nature-field-gra-130247647.jpg',
                 AppConfig.BASE_PATH + popupData.data[0].value,
                  height: 200,
                  fit: BoxFit.cover,
                ),
                Text(
                  '',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Dismiss'),
              ),
            ],
          ),
        );
    
    //print(imageList[0].value);
  }



  void initState() {
    localProvider= Provider.of<LocaleProvider>(context, listen: false);
    fatchPopupData();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
    //  AlertDialog(
    //   contentPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
    //   title: Row(
    //     mainAxisAlignment: MainAxisAlignment.end,
    //     children: [
    //       IconButton(
    //           onPressed: () {
    //             Navigator.pop(context);
    //           },
    //           icon: Icon(Icons.close))
    //     ],
    //   ),
    //   content: Stack(
    //     alignment: Alignment.center,
    //     children: <Widget>[
    //      popupimage == null ?Text("loading"):Image.network(
    //         popupimage,
    //         height: 200,
    //         // loadingBuilder: (context, child, loading) {
    //         //   if (loading == null) return child;
    //         //   return Container(
    //         //     height: 90,
    //         //     child: Center(
    //         //       child: CircularProgressIndicator(),
    //         //     ),
    //         //   );
    //         // },
    //       ),
    //       Positioned(
    //         bottom: 0,
    //         child: Text(
    //       popuplist.data[0].id.toString() ,
    //           style: TextStyle(
    //             fontSize: 24,
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    //   actions: [
    //     TextButton(
    //       onPressed: () => Navigator.pop(context),
    //       child: const Text(
    //         '',
    //         style: TextStyle(
    //           fontSize: 18,
    //         ),
    //       ),
    //     ),
    //   ],
    // );
       
    }
    );
    // TODO: implement initState
    //re appear statusbar in case it was not there in the previous page
    SystemChrome.setEnabledSystemUIOverlays(
        [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    super.initState();
  }
ShowNothing(){
  print("no image");
}
  bool isLoad = true;
  // Widget _dialog(BuildContext context) {
  //   return 
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        print("_currentIndex");
        if (_currentIndex != 0) {
          setState(() {
            _currentIndex = 0;
          });
          return false;
        } else {
          // CommonFunctions(context).appExitDialog();
          showExitPopup(context); //modify
        }
        return widget.go_back;
      },
      child: Directionality(
        textDirection:
            app_language_rtl.$ ? TextDirection.rtl : TextDirection.ltr,
        child: Scaffold(
          backgroundColor: Colors.white,
          extendBody: true,
          body: _children[_currentIndex],
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          //specify the location of the FAB
          floatingActionButton: Visibility(
            visible: MediaQuery.of(context).viewInsets.bottom ==
                0.0, // if the kyeboard is open then hide, else show
            child: FloatingActionButton(
              backgroundColor: MyTheme.white,
              onPressed: () {},
              tooltip: "start FAB",
              child: Container(
                  margin: EdgeInsets.all(0.0),
                  child: IconButton(
                      icon: new Image.asset('assets/square_logo.png'),
                      tooltip: 'Action',
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Filter2(
                            selected_filter: "Products",
                          );
                        }));
                      })),
              elevation: 10.0,
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            shape: CircularNotchedRectangle(),
            notchMargin: 5,
            color: Color(0xff66F1D0),
            clipBehavior: Clip.antiAlias,
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                onTap: onTapped,
                currentIndex: _currentIndex,
                backgroundColor: Color(0xff66F1D0),
                // fixedColor: Theme.of(context).accentColor,
                fixedColor: MyTheme.red_color,
                unselectedItemColor: Colors.red,
                // Color.fromRGBO(153, 153, 153, 1),
                items: [
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/home.png",
                        color: _currentIndex == 0
                            ? MyTheme.black_color
                            : Colors.black87,
                        // Color.fromRGBO(153, 153, 153, 1),
                        height: 20,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizations.of(context)
                              .main_screen_bottom_navigation_home,
                          style: TextStyle(
                            fontSize: 12,
                            color: _currentIndex == 0
                                ? MyTheme.black_color
                                : Colors.black87,
                            // Color.fromRGBO(153, 153, 153, 1),
                          ),
                        ),
                      )),
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/categories.png",
                        color: _currentIndex == 1
                            ? MyTheme.black_color
                            : Colors.black87,
                        //Color.fromRGBO(153, 153, 153, 1),
                        height: 20,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizations.of(context)
                              .main_screen_bottom_navigation_categories,
                          style: TextStyle(
                            fontSize: 12,
                            color: _currentIndex == 1
                                ? MyTheme.black_color
                                : Colors.black87,
                            //Color.fromRGBO(153, 153, 153, 1),
                          ),
                        ),
                      )),
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.circle,
                      color: Colors.transparent,
                    ),
                    title: Text(""),
                  ),
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/cart.png",
                        color: _currentIndex == 3
                            ? MyTheme.black_color
                            : Colors.black87,
                        //Color.fromRGBO(153, 153, 153, 1),
                        height: 20,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizations.of(context)
                              .main_screen_bottom_navigation_cart,
                          style: TextStyle(
                            fontSize: 12,
                            color: _currentIndex == 3
                                ? MyTheme.black_color
                                : Colors.black87,
                            //Color.fromRGBO(153, 153, 153, 1),
                          ),
                        ),
                      )),
                  BottomNavigationBarItem(
                      icon: Image.asset(
                        "assets/profile.png",
                        color: _currentIndex == 4
                            ? MyTheme.black_color
                            : Colors.black87,
                        // Color.fromRGBO(153, 153, 153, 1),
                        height: 20,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          AppLocalizations.of(context)
                              .main_screen_bottom_navigation_profile,
                          style: TextStyle(
                            fontSize: 12,
                            color: _currentIndex == 4
                                ? MyTheme.black_color
                                : Colors.black87,

                            //Color.fromRGBO(153, 153, 153, 1),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> showExitPopup(context) async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 90,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Do you want to exit?"),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            print('yes selected');
                            exit(0);
                          },
                          child: Text("Yes",
                              style: TextStyle(color: Colors.black)),
                          style: ElevatedButton.styleFrom(
                              primary: MyTheme.green_accent_color_d0),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                          child: ElevatedButton(
                        onPressed: () {
                          print('no selected');
                          Navigator.of(context).pop();
                        },
                        child:
                            Text("No", style: TextStyle(color: Colors.black)),
                        style: ElevatedButton.styleFrom(
                          primary: MyTheme.green_accent_color_f1,
                        ),
                      ))
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
