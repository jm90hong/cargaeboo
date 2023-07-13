



import '../database.dart';

class MyFloor{
  var database;

  static init() async{
    await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  }


}