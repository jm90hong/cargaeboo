

import 'dart:async';
import 'package:cargaeboo/dao/car_dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'entity/car.dart';





@Database(version: 1, entities: [Car])
abstract class AppDatabase extends FloorDatabase {
  CarDao get carDao;
}