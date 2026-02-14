import 'package:g_sync/src/functions/objects/models/tables.dart';
import 'package:hive_ce/hive.dart';

import '../../../../core/constants/category.dart';

part 'download_table.g.dart';

@HiveType(typeId: CategoryType.downloadTable)
class GSDownloadTable extends GSBaseTable<GSDownloadData> {
  @override
  @HiveField(0)
  int tableKey;

  @override
  @HiveField(1)
  String tableName;

  @override
  @HiveField(2)
  DateTime lastUpdateTime;

  @override
  @HiveField(3)
  List<GSDownloadData> rows;

  GSDownloadTable({
    required this.tableKey,
    required this.tableName,
    required this.lastUpdateTime,
    this.rows = const [],
  });

  @override
  GSDownloadTable copyWith({
    int? tableKey,
    String? tableName,
    DateTime? lastUpdateTime,
    List<GSDownloadData>? rows,
  }) => GSDownloadTable(
    tableKey: tableKey ?? this.tableKey,
    tableName: tableName ?? this.tableName,
    lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
    rows: rows ?? this.rows,
  );

  @override
  GSDownloadData createRowData(
    int index,
    Map<String, dynamic> data, [
    Map<String, String>? files,
  ]) {
    return GSDownloadData(index: index, data: data);
  }

  @override
  Future<void> saveTable() async {
    final table = Tables.downloadTable;
    await table.put(tableKey, this);
  }
}

@HiveType(typeId: CategoryType.downloadData)
class GSDownloadData extends GSBaseData {
  @override
  @HiveField(0)
  final int index;

  @override
  @HiveField(1)
  Map<String, dynamic>? data;

  GSDownloadData({required this.index, this.data});

  GSDownloadData copyWith({int? index, Map<String, dynamic>? data}) {
    return GSDownloadData(index: index ?? this.index, data: data ?? this.data);
  }
}
