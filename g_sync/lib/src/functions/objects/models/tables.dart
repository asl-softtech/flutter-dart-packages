import 'package:hive_ce/hive.dart';

abstract class GSBaseTable<T extends GSBaseData> extends HiveObject {
  int get tableKey;

  String get tableName;

  DateTime get lastUpdateTime;

  List<T> get rows;

  GSBaseTable<T> copyWith({
    int? tableKey,
    String? tableName,
    DateTime? lastUpdateTime,
    List<T>? rows,
  });

  Future<void> saveTable();

  T createRowData(
    int index,
    Map<String, dynamic> data, [
    Map<String, String>? files,
  ]);
}

abstract class GSBaseData extends HiveObject {
  int get index;

  Map<String, dynamic>? get data;
}
