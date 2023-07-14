


import 'dart:convert';
import 'dart:io';

import 'package:cargaeboo/config/my_color.dart';
import 'package:cargaeboo/config/my_widget.dart';
import 'package:cargaeboo/util/my_floor.dart';
import 'package:cargaeboo/util/my_util.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as Img;
import 'package:provider/provider.dart';

import '../database.dart';
import '../entity/car.dart';
import '../model/car_model.dart';


class AddCarScreen extends StatefulWidget {
  const AddCarScreen({super.key});

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {


  String curBase64='n';
  TextEditingController nameCotroller = TextEditingController();
  TextEditingController yearCotroller = TextEditingController();
  TextEditingController monthCotroller = TextEditingController();



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
                          child: curBase64=='n' ?
                          Image.asset('assets/img/logo.png',width: 70,) :
                          imageFromBase64String(curBase64)
                      ),
                      const SizedBox(height: 30,),
                      Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        width: MediaQuery.of(context).size.width*0.8,
                        child: TextFormField(
                          controller: nameCotroller,
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
                          controller: yearCotroller,
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
                          controller: monthCotroller,
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
                onTap: () async{

                  if(nameCotroller.text.isEmpty){
                    MyUtil.showToast('차량명을 입력해주세요');
                    return;
                  }
                  if(yearCotroller.text.isEmpty){
                    MyUtil.showToast('차량연식(년도) 입력해주세요');
                    return;
                  }
                  if(monthCotroller.text.isEmpty){
                    MyUtil.showToast('차량연식(월) 입력해주세요');
                    return;
                  }

                  Car car = Car(
                    base64: curBase64,
                    name: nameCotroller.text,
                    buyYear: yearCotroller.text.toString(),
                    buyMonth: monthCotroller.text.toString()
                  );

                  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
                  final carDao = database.carDao;
                  carDao.insertCar(car);


                  MyUtil.showToast('${nameCotroller.text} 추가 완료!');
                  Provider.of<CarModel>(context,listen: false).getMyCars();
                  Navigator.pop(context);


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


Widget imageFromBase64String(String base64String) {
  return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.memory(base64Decode(base64String),width: 100,height: 100,fit: BoxFit.cover,)
  );
}