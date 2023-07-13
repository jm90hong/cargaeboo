

import 'package:floor/floor.dart';

import '../entity/car.dart';

@dao
abstract class CarDao{

  @Query('SELECT * FROM Car')
  Future<List<Car>> findAllCars();

  @Query('DELETE FROM Car WHERE idx = :idx')
  Future<void> deleteCarById(int idx);

  @insert
  Future<void> insertCar(Car car);
}