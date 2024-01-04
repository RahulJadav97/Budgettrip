

import 'package:BudgeTrip/Common/Common_Color.dart';
import 'package:BudgeTrip/chat/screen/user_list.dart';
import 'package:BudgeTrip/user/home/screen/search_screen.dart';
import 'package:BudgeTrip/user/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';


class BottomNavbarScreen extends StatefulWidget {
  int? newIndex;
 BottomNavbarScreen({Key? key,required this.newIndex}) : super(key: key);

  @override
  State<BottomNavbarScreen> createState() => _BottomNavbarScreenState();
}

class _BottomNavbarScreenState extends State<BottomNavbarScreen> {

  int current_index = 0;
  var user_id;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List Screens = <Widget>[
      SearchScreen(),
      UserListScreen(),
      ProfileScreen(),
    ];

    return WillPopScope(
      onWillPop: () {
        SystemNavigator.pop();
        return Future.value(false);
      },
      child: Scaffold(
        body:Screens[widget.newIndex!.toInt()],
        bottomNavigationBar: BottomNavigationBarTheme(
          data: BottomNavigationBarThemeData(
              backgroundColor: Colors.white,
            elevation: 0
          ),
          child: BottomNavigationBar(
            onTap: (val){
              setState(() {
                widget.newIndex=val;
              });
            },
            backgroundColor: Colors.white,
            showSelectedLabels: true,
            type: BottomNavigationBarType.fixed,
            elevation: 0,
            iconSize: 32,
            enableFeedback: false,
            currentIndex:  int.parse( widget.newIndex.toString()),
            selectedFontSize: 14,
            unselectedFontSize: 14,
            showUnselectedLabels: true,
            selectedItemColor: common_blue,
            unselectedItemColor: Colors.black,
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.home_outlined,), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.wechat), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
            ],

          ),
        ),
      ),
    );
  }
}
