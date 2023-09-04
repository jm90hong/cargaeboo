


import 'package:floor/floor.dart';

import '../entity/history.dart';

@dao
abstract class HistoryDao{
  @Query('SELECT * FROM History ORDER BY idx DESC')
  Future<List<History>> findAllHistory();

  @Query('DELETE FROM History WHERE idx = :idx')
  Future<void> deleteHistoryByIdx(int idx);

  @Query('SELECT * FROM History WHERE idx = :idx')
  Future<History?> findHistoryByIdx(int idx);

  @Query('SELECT * FROM History WHERE carIdx = :idx ORDER BY idx ASC' )
  Future<List<History>> findHistoryByCarIdx(int idx);

  @update
  Future<void> updateHistory(History history);

  @insert
  Future<void> insertHistory(History history);
}