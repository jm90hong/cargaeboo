import 'package:flutter/material.dart';

import '../config/my_color.dart';
import '../config/my_widget.dart';


class AppInfoScreen extends StatefulWidget {
  const AppInfoScreen({super.key});

  @override
  State<AppInfoScreen> createState() => _AppInfoScreenState();
}

class _AppInfoScreenState extends State<AppInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor:Colors.white,
          title: Text('앱정보',style: TextStyle(fontFamily: 'nt_bold',color: Colors.black),)
      ),
      body: FullContainer(

        child: Column(
          children: [

          ],
        ),
      ),
    );
  }
}
