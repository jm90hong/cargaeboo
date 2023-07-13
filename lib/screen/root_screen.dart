
import 'package:cargaeboo/config/my_color.dart';
import 'package:flutter/material.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _selectedIndex=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Image.asset('assets/img/logo.png',height: 40,fit: BoxFit.cover,)
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [

          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        selectedItemColor: MyColor.main,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        onTap: (index){
          setState(() {
            _selectedIndex=index;
          });
        },
      ),
    );
  }
}
