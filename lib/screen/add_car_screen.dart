


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
                child: Column(
                  children: [

                    //todo 사진 등록
                    GestureDetector(
                        onTap:() async{
                          XFile? f = await ImagePicker().pickImage(source: ImageSource.gallery);

                          if(f != null){
                            File _file = File(f.path);

                            //사진 resize
                            final image = Img.decodeImage(_file.readAsBytesSync())!;
                            final resizedImage = Img.copyResize(image, width: 360);
                            var bytes = Img.encodePng(resizedImage);
                            String base64String = base64.encode(bytes);
                            print(base64String);
                            setState(() {
                              curBase64=base64String;
                            });

                          }
                        },
                        child: curBase64=='' ?
                        Image.asset('assets/img/logo.png',width: 70,) :
                        imageFromBase64String(curBase64)
                    )


                  ],
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