


import 'package:flutter/material.dart';

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({super.key});

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {


  String curBase64='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('내 차량 등록'),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            //todo 입력 폼
            Expanded(
                child: Column(
                  children: [

                    //todo 사진 등록
                    Image.asset()


                  ],
                )
            ),
            //todo 버튼
          ],
        ),
      ),
    );
  }
}
