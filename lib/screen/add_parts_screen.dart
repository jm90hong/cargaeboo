


import 'dart:convert';
import 'dart:io';

import 'package:cargaeboo/config/my_color.dart';
import 'package:cargaeboo/config/my_widget.dart';
import 'package:cargaeboo/entity/parts.dart';
import 'package:cargaeboo/model/parts_model.dart';
import 'package:cargaeboo/util/my_floor.dart';
import 'package:cargaeboo/util/my_util.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as Img;
import 'package:provider/provider.dart';

import '../database.dart';
import '../entity/car.dart';
import '../model/car_model.dart';


class AddPartsScreen extends StatefulWidget {

  bool isNew = true;
  int idx=0;
  String name;


  AddPartsScreen({
    required this.isNew,
    this.idx=0,
    this.name=''
  });

  @override
  State<AddPartsScreen> createState() => _AddPartsScreenState();
}

class _AddPartsScreenState extends State<AddPartsScreen> {



  TextEditingController nameCotroller = TextEditingController();
  TextEditingController dCotroller = TextEditingController();
  TextEditingController pCotroller = TextEditingController();
  Parts? parts;


  void init() async{
    if(!widget.isNew){
      final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
      final partsDao = database.partsDao;
      parts = await partsDao.findPartsByIdx(widget.idx);
      nameCotroller.text='${parts?.name}';
      dCotroller.text='${parts?.durationDistance}';
      pCotroller.text='${parts?.durationPeriod}';
    }

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.isNew ?
          Text('소모품 등록',style: TextStyle(fontWeight: FontWeight.bold),) :
          Text('${widget.name}',style: TextStyle(fontWeight: FontWeight.bold),)
        ,
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
                      const SizedBox(height: 30,),
                      Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        width: MediaQuery.of(context).size.width*0.8,
                        child: TextFormField(
                          controller: nameCotroller,
                          decoration: const InputDecoration(
                            hintText: '엔진오일',
                            labelText: '소모품명',
                            labelStyle: TextStyle(fontWeight:FontWeight.bold)
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        width: MediaQuery.of(context).size.width*0.8,
                        child: TextFormField(
                          controller: dCotroller,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              hintText: '10000',
                              labelText: '교환 주기 (km)',
                              labelStyle: TextStyle(fontWeight:FontWeight.bold)
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 30),
                        width: MediaQuery.of(context).size.width*0.8,
                        child: TextFormField(
                          controller: pCotroller,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                              hintText: '6',
                              labelText: '[선택사항] 교환 주기 (개월) ',
                              labelStyle: TextStyle(fontWeight:FontWeight.bold)
                          ),
                        ),
                      ),
                      
                      
                      //todo 소모품 교환주기 정보
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('차량 소모품 교환주기(참고)',style: TextStyle(fontWeight: FontWeight.bold),),
                            SizedBox(height: 10,),
                            Text(''
                                '엔진오일 : 10,000km\n'
                                '에어컨필터 : 6,000km\n'
                                '타이어 : 40,000km (마모선 상시 확인)\n'
                                '타이어 위치교환 : 10,000km (마모선 상시 확인)\n'
                                '자동변속기오일 : 40,000 ~ 100,000km\n'
                                '수공변속기오일 : 100,000km\n'
                                '브레이크액 : 100,000km\n'
                                '브레이크패드 : 40,000km\n'
                                '브레이크라이닝 : 100,000 ~ 200,000km\n'
                                '점화플러그 및 점화케이블 : 6000km\n'
                                '부동액 : 2년\n'
                                '배터리 : 4년\n'
                                '연료필터 : 6000km\n'
                                '타이밍벨트 : 6000km\n'
                                ,style: TextStyle(color: Color(0xff999999),fontSize: 13),)
                          ],
                        ),
                      )
                      
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
                    MyUtil.showToast('소모품명을 입력해주세요');
                    return;
                  }
                  if(dCotroller.text.isEmpty){
                    MyUtil.showToast('교환주기(km) 입력해주세요');
                    return;
                  }


                  if(widget.isNew){
                    Parts parts = Parts(
                        name: nameCotroller.text,
                        durationDistance: dCotroller.text.toString(),
                        durationPeriod: pCotroller.text.toString()
                    );

                    final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
                    final partsDao = database.partsDao;
                    partsDao.insertParts(parts);


                    MyUtil.showToast('${nameCotroller.text} 추가 완료!');

                  }else{
                    Parts parts = Parts(
                        idx: widget.idx,
                        name: nameCotroller.text,
                        durationDistance: dCotroller.text.toString(),
                        durationPeriod: pCotroller.text.toString()
                    );

                    final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
                    final partsDao = database.partsDao;
                    partsDao.updateParts(parts);

                    MyUtil.showToast('${nameCotroller.text} 수정 완료!');
                  }

                  Provider.of<PartsModel>(context,listen: false).getMyParts();
                  Navigator.pop(context);

                  

                },
                text: widget.isNew ? '소모품 등록하기' : '수정하기',
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