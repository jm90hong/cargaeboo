

import 'package:flutter/material.dart';

import '../database.dart';
import '../entity/car.dart';
import '../entity/parts.dart';


class PartsModel extends ChangeNotifier{
  List<Parts> myParts = [];

  void getMyParts() async{
    myParts=[];
    final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
    final partsDao = database.partsDao;
    myParts = await partsDao.findAllParts();
    notifyListeners();
  }





}