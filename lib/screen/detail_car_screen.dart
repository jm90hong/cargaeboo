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
    w=[];
    final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final partsDao = database.partsDao;
    final historyDao = database.historyDao;


    allParts = await partsDao.findAllParts();
    allHistory = await historyDao.findHistoryByCarIdx(widget.car.idx??0);


    for(var a in allHistory){
      print(a.carIdx);
    }

    for(Parts parts in allParts){
      String lastDistance='0';
      w.add(Padding(
        padding: const EdgeInsets.only(top: 15),
        child: Text(parts.name+' 교환 이력',style: const TextStyle(color: Colors.black87,fontWeight: FontWeight.bold),),
      ));
      for(History history in allHistory.where((element) => element.partsIdx==parts.idx)){
        w.add(
            Padding(
                padding: EdgeInsets.only(top: 2),
                child: Text('${history.date} : ${history.distance} km 에 교환완료')
            )
        );
        lastDistance=history.distance;
      }
      w.add(Text('다음 교환시기:  ${int.parse(lastDistance)+int.parse(parts.durationDistance)} km',
        style: TextStyle(color: Colors.blueAccent,fontWeight: FontWeight.bold),)
      );
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
        title: Text(widget.car.name,style: TextStyle(fontWeight: FontWeight.bold),),
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
                        'assets/img/car.png',
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
                Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:w,
                    ),
                  ],
                )
                
                
                
              ],
            ),
          )
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: MyColor.mainColor,
        onPressed: () async{
          await Navigator.push(
           context, MaterialPageRoute(builder: (context) => AddHistoryScreen(car: widget.car,)),
          );
          makeHistory();
        },
        child: const Icon(Icons.edit,color: Colors.white,),
      ),
    );
  }
}
