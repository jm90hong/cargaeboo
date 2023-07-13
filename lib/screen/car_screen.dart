import 'package:cargaeboo/screen/add_car_screen.dart';
import 'package:flutter/material.dart';

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
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
            context, MaterialPageRoute(builder: (context) => AddCarScreen()),
          );
        },
        child: Icon(Icons.add),
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

























