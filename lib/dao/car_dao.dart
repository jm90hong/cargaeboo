

import 'package:floor/floor.dart';

import '../entity/car.dart';

@dao
abstract class CarDao{

  @Query('SELECT * FROM Car ORDER BY idx DESC')
  Future<List<Car>> findAllCars();

  @Query('DELETE FROM Car WHERE idx = :idx')
  Future<void> deleteCarByIdx(int idx);

  @Query('SELECT * FROM Car WHERE idx = :idx')
  Future<Car?> findCarByIdx(int idx);

  @insert
  Future<void> insertCar(Car car);
}