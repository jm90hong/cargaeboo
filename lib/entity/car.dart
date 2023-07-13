
import 'package:floor/floor.dart';

@entity
class Car{

  @PrimaryKey(autoGenerate: true)
  late final int? idx;

  final String name;
  final int buyYear;
  final int buyMonth;

  Car({
    this.idx,
    required this.name,
    required this.buyMonth,
    required this.buyYear
  });
}