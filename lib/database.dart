

import 'dart:async';
import 'package:cargaeboo/dao/car_dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'entity/car.dart';


part 'database.g.dart';

//todo 참고 사이트 https://mobikul.com/floor-database/
@Database(version: 1, entities: [Car])
abstract class AppDatabase extends FloorDatabase {
  CarDao get carDao;
}