import 'dart:convert';

import 'package:cargaeboo/model/car_model.dart';
import 'package:cargaeboo/screen/add_car_screen.dart';
import 'package:cargaeboo/screen/detail_car_screen.dart';
import 'package:cargaeboo/util/my_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../config/my_color.dart';
import '../config/my_widget.dart';
import '../database.dart';
import '../entity/car.dart';


class CarScreen extends StatefulWidget {
  const CarScreen({super.key});

  @override
  State<CarScreen> createState() => _CarScreenState();
}

class _CarScreenState extends State<CarScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CarModel>(context,listen: false).getMyCars();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            const SizedBox(height: 25,),
            SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('당신의 소중한 자동차의',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey),),
                  Text('소모품을 관리하세요.' ,style: TextStyle(color: MyColor.mainColor,fontSize: 18,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            const SizedBox(height: 20,),
            SingleChildScrollView(
              child: Consumer<CarModel>(builder: (context, carModel, child){
                return Expanded(
                  child: Column(
                    children: carModel.myCars.map((e) => CarBox(car: e)).toList(),
                  ),
                );
              },)
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColor.mainColor,
        onPressed: (){
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddCarScreen()),
          );
        },
        child: const Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}



class CarBox extends StatelessWidget {
  Car car;



  CarBox({required this.car});


  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap: (){
        Navigator.push(
          context, MaterialPageRoute(builder: (context) => DetailCarScreen(car: car)),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 20),
        width: double.infinity,
        height: 70,
        color: Colors.white,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            Expanded(
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child:car.base64=='n' ?
                    Image.asset(
                      'assets/img/logo.png',
                      height:70,
                      width: 70,
                      fit: BoxFit.cover,
                    ) :
                    Image.memory(
                      base64Decode(car.base64),
                      height:70,
                      width: 70,
                      fit: BoxFit.cover,),
                  ),
                  const SizedBox(width: 20,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(car.name,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 21),),
                      Text('${car.buyYear}년 ${car.buyMonth}월 출고',style: TextStyle(color: Colors.black87,fontSize: 13),)
                    ],
                  ),
                ],
              ),
            ),

           IconButton(
               onPressed: (){
                 showDialog<void>(
                   context: context,
                   builder: (BuildContext context) {
                     return AlertDialog(
                       title: const Text('차량 삭제'),
                       content: Text(
                         '${car.name} 을 삭제 하시겠습니까?'
                       ),
                       actions: <Widget>[
                         TextButton(
                           style: TextButton.styleFrom(
                             textStyle: Theme.of(context).textTheme.labelLarge,
                           ),
                           child: const Text('삭제하기'),
                           onPressed: () async{

                             final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
                             final carDao = database.carDao;

                             carDao.deleteCarByIdx(car.idx ?? 0);
                             Provider.of<CarModel>(context,listen: false).getMyCars();
                             MyUtil.showToast('차량 삭제 완료');
                             Navigator.of(context).pop();
                           },
                         ),
                         TextButton(
                           style: TextButton.styleFrom(
                             textStyle: Theme.of(context).textTheme.labelLarge,
                           ),
                           child: const Text('취소'),
                           onPressed: () {
                             Navigator.of(context).pop();
                           },
                         ),
                       ],
                     );
                   },
                 );
               }, 
               icon: Icon(Icons.remove_circle_outline,size: 24,color: Colors.grey.shade400,)
           )
          ],
        ),
      ),
    );
  }
}

























