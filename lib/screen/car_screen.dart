import 'package:cargaeboo/screen/add_car_screen.dart';
import 'package:flutter/material.dart';

import '../config/my_color.dart';
import '../config/my_widget.dart';
import '../entity/car.dart';


class CarScreen extends StatefulWidget {
  const CarScreen({super.key});

  @override
  State<CarScreen> createState() => _CarScreenState();
}

class _CarScreenState extends State<CarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FullContainer(
        child: Column(
          children: [

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
        child: Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}



class CarBox extends StatelessWidget {
  Car car;

  CarBox({required this.car});


  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      color: Colors.white,
      child: Row(
        children: [

        ],
      ),
    );
  }
}

























