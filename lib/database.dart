

import 'dart:async';
import 'package:cargaeboo/dao/car_dao.dart';
import 'package:cargaeboo/dao/parts_dao.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'dao/history_dao.dart';
import 'entity/car.dart';
import 'entity/history.dart';
import 'entity/parts.dart';


part 'database.g.dart';

//todo 참고 사이트 https://mobikul.com/floor-database/
//todo flutter packages pub run build_runner build or flutter packages pub run build_runner watch

@Database(version: 1, entities: [Car, Parts, History])
abstract class AppDatabase extends FloorDatabase {
  CarDao get carDao;
  PartsDao get partsDao;
  HistoryDao get historyDao;
}