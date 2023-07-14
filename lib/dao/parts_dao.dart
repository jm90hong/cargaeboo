




import 'package:floor/floor.dart';

import '../entity/parts.dart';

@dao
abstract class PartsDao{
  @Query('SELECT * FROM Parts ORDER BY idx DESC')
  Future<List<Parts>> findAllParts();

  @Query('DELETE FROM Parts WHERE idx = :idx')
  Future<void> deletePartsByIdx(int idx);

  @Query('SELECT * FROM Parts WHERE idx = :idx')
  Future<Parts?> findPartsByIdx(int idx);

  @update
  Future<void> updateParts(Parts parts);

  @insert
  Future<void> insertParts(Parts parts);
}