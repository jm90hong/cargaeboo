


import 'dart:convert';
import 'dart:io';

import 'package:cargaeboo/config/my_color.dart';
import 'package:cargaeboo/config/my_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as Img;


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
        title: Text('내 차량 등록',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: FullContainer(
        child: Column(
          children: [
            //todo 입력 폼
            Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 50,),
                      //todo 사진 등록
                      const Text('차량 사진 등록',style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),),
                      const SizedBox(height: 12,),
                      GestureDetector(
                          onTap:() async{
                            XFile? f = await ImagePicker().pickImage(source: ImageSource.gallery);

                            if(f != null){
                              File file = File(f.path);

                              //사진 resize
                              final image = Img.decodeImage(file.readAsBytesSync())!;
                              final resizedImage = Img.copyResize(image, width: 360);
                              var bytes = Img.encodePng(resizedImage);
                              String base64String = base64.encode(bytes);
                              setState(() {
                                curBase64=base64String;
                              });

                            }
                          },
                          child: curBase64=='' ?
                          Image.asset('assets/img/logo.png',width: 70,) :
                          imageFromBase64String(curBase64)
                      ),
                      const SizedBox(height: 30,),
                      Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        width: MediaQuery.of(context).size.width*0.8,
                        child: TextFormField(
                          decoration: const InputDecoration(
                            hintText: '멋진 아반떼 N',
                            labelText: '차량명(별칭)',
                            labelStyle: TextStyle(fontWeight:FontWeight.bold)
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        width: MediaQuery.of(context).size.width*0.8,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              hintText: '2023',
                              labelText: '차량 연식(연도)',
                              labelStyle: TextStyle(fontWeight:FontWeight.bold)
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        width: MediaQuery.of(context).size.width*0.8,
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              hintText: '3',
                              labelText: '차량 연식(월)',
                              labelStyle: TextStyle(fontWeight:FontWeight.bold)
                          ),
                        ),
                      ),
                    ],
                  ),
                )
            ),
            //todo 버튼
            LongButton(
                width: MediaQuery.of(context).size.width*0.9,
                borderRadius: 10,
                onTap: (){

                },
                text: '차량 등록하기',
                backgroundColor:MyColor.mainColor
            )
          ],
        ),
      ),
    );
  }
}


Image imageFromBase64String(String base64String) {
  return Image.memory(base64Decode(base64String),width: 80,);
}