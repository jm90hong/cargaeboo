

import 'package:flutter/material.dart';

import '../database.dart';
import '../entity/car.dart';

class CarModel extends ChangeNotifier{
  List<Car> myCars = [];

  void getMyCars() async{
    myCars=[];
    final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final carDao = database.carDao;
    myCars = await carDao.findAllCars();
    notifyListeners();
  }

}