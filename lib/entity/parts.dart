import 'package:floor/floor.dart';

@entity
class Parts{

  @PrimaryKey(autoGenerate: true)
  late final int? idx;

  final String name;
  final String durationDistance;
  final String durationPeriod;

  Parts({
    this.idx,
    required this.name,
    required this.durationDistance,
    required this.durationPeriod
  });
}