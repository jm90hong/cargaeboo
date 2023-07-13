



import '../database.dart';

class MyFloor{
  var database;

  static init() {
    $FloorAppDatabase.databaseBuilder('app_database.db').build();
  }


}