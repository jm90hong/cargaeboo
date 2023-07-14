
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

      body: FullContainer(
        child: screens[_selectedIndex]
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(0xffffffff),
        selectedItemColor: Colors.black87,
        unselectedItemColor: Colors.grey.shade400,
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
            label: '내 소포품',
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
