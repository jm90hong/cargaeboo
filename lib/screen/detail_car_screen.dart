import 'dart:convert';

import 'package:cargaeboo/config/my_widget.dart';
import 'package:flutter/material.dart';

import '../config/my_color.dart';
import '../entity/car.dart';



class DetailCarScreen extends StatefulWidget {

  Car car;

  DetailCarScreen({required this.car});


  @override
  State<DetailCarScreen> createState() => _DetailCarScreenState();
}

class _DetailCarScreenState extends State<DetailCarScreen> {

  TextStyle titleStyle = TextStyle(fontWeight: FontWeight.bold,fontSize: 16);
    
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
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
          //Navigator.push(
           // context, MaterialPageRoute(builder: (context) => AddCarScreen()),
         // );
        },
        child: const Icon(Icons.edit,color: Colors.white,),
      ),
    );
  }
}
