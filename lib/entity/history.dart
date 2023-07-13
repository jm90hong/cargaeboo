import 'package:floor/floor.dart';

@entity
class History{

  @PrimaryKey(autoGenerate: true)
  late final int? idx;
  final int carIdx;
  final int partsIdx;
  final int distance;
  final String date;

  History({
    this.idx,
    required this.carIdx,
    required this.partsIdx,
    required this.distance,
    required this.date
  });
}