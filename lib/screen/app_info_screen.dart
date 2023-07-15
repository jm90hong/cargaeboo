import 'package:flutter/material.dart';

import '../config/my_color.dart';
import '../config/my_widget.dart';


class AppInfoScreen extends StatefulWidget {
  const AppInfoScreen({super.key});

  @override
  State<AppInfoScreen> createState() => _AppInfoScreenState();
}

class _AppInfoScreenState extends State<AppInfoScreen> {

  TextStyle style1 = TextStyle(color: Color(0xff999999),fontSize: 12,fontWeight: FontWeight.bold);
  TextStyle style2 = TextStyle(color: Color(0xff222222),fontSize: 14,fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor:Colors.white,
          title: const Text('앱정보',style: TextStyle(fontFamily: 'nt_bold',color: Colors.black),)
      ),
      body: FullContainer(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('제작자',style: style1,),
            Text('JM.DEVELOPER',style: style2,),
            const SizedBox(height: 10,),
            Text('앱버전',style: style1,),
            Text('1.1.1',style: style2,),
            const SizedBox(height: 10,),
            Text('문의',style: style1,),
            Text('hong.jm.developer@gmail.com',style: style2,),
          ],
        ),
      ),
    );
  }
}
