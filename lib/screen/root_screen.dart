
import 'package:cargaeboo/config/my_color.dart';
import 'package:cargaeboo/screen/app_info_screen.dart';
import 'package:cargaeboo/screen/car_screen.dart';
import 'package:cargaeboo/screen/parts_screen.dart';
import 'package:flutter/material.dart';

import '../config/my_widget.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _selectedIndex=0;
  List<Widget> screens = [
    CarScreen(),
    PartsScreen(),
    AppInfoScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor:Colors.white,
        title: Row(
          children: [
            Image.asset('assets/img/logo.png',height: 40,fit: BoxFit.cover,)
          ],
        ),
      ),
      body: FullContainer(
        child: screens[_selectedIndex]
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: MyColor.mainColor,
        selectedItemColor: Colors.white,
        unselectedItemColor: Color(0xffEAEAEA),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        iconSize: 23,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: '내 차량',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: '소포품 관리',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info_outline),
            label: '앱정보',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index){
          setState(() {
            _selectedIndex=index;
          });
        },
      ),
    );
  }
}
