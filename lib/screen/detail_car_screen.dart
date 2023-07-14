import 'dart:convert';

import 'package:cargaeboo/config/my_widget.dart';
import 'package:cargaeboo/entity/history.dart';
import 'package:cargaeboo/screen/add_history_screen.dart';
import 'package:cargaeboo/util/my_util.dart';
import 'package:flutter/material.dart';

import '../config/my_color.dart';
import '../database.dart';
import '../entity/car.dart';
import '../entity/parts.dart';



class DetailCarScreen extends StatefulWidget {

  Car car;

  DetailCarScreen({required this.car});


  @override
  State<DetailCarScreen> createState() => _DetailCarScreenState();
}

class _DetailCarScreenState extends State<DetailCarScreen> {

  TextStyle titleStyle = TextStyle(fontWeight: FontWeight.bold,fontSize: 16);

  List<Parts> allParts = [];
  List<History> allHistory= [];

  List<Widget> w = [];

  makeHistory() async{
    final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final partsDao = database.partsDao;
    final historyDao = database.historyDao;


    MyUtil.showToast(widget.car.idx.toString());
    allParts = await partsDao.findAllParts();
    allHistory = await historyDao.findHistoryByCarIdx(2);


    for(var a in allHistory){
      print(a.carIdx);
    }

    for(Parts parts in allParts){
      w.add(Text(parts.name));
      for(History history in allHistory.where((element) => element.partsIdx==parts.idx)){
        w.add(Text('${history.date} / ${history.distance} km'));
      }
      w.add(Text('마지막'));
    }

    setState(() {});



  }
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    makeHistory();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.car.name}',style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: FullContainer(
        padding: EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child:widget.car.base64=='n' ?
                      Image.asset(
                        'assets/img/logo.png',
                        height:100,
                        width: 100,
                        fit: BoxFit.cover,
                      ) :
                      Image.memory(
                        base64Decode(widget.car.base64),
                        height:100,
                        width: 100,
                        fit: BoxFit.cover,),
                    ),
                    SizedBox(width: 20,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 6,),
                        Text(widget.car.name,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black,fontSize: 21),),
                        Text('${widget.car.buyYear}년 ${widget.car.buyMonth}월 출고',style: TextStyle(color: Colors.black87,fontSize: 13),)
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Text('교환이력',style: titleStyle,),
                SizedBox(height: 15,),
                Column(
                  children: [
                    
                    //todo 엔진오일
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('엔진오일 교환 이력',style: TextStyle(color: Colors.black87,fontWeight: FontWeight.bold),),
                        Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: Text('2023년 7월 14일/ 12999km 때 교환')
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: Text('2023년 7월 14일/ 12999km 때 교환')
                        ),
                        Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: Text('2023년 7월 14일/ 12999km 때 교환')
                        ),
                        Text('다음 교환은 20999km 일 때',style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold),)
                      ],
                    )
                    
                  ],
                )
                
                
                
              ],
            ),
          )
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColor.mainColor,
        onPressed: (){
          Navigator.push(
           context, MaterialPageRoute(builder: (context) => AddHistoryScreen(car: widget.car,)),
         );
        },
        child: const Icon(Icons.edit,color: Colors.white,),
      ),
    );
  }
}
