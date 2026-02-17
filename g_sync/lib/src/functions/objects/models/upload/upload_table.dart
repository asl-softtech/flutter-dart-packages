import 'package:g_sync/src/functions/objects/models/tables.dart';
import 'package:hive_ce/hive.dart';

import '../../../../core/constants/category.dart';

part 'upload_table.g.dart';

@HiveType(typeId: CategoryType.uploadTable)
class GSUploadTable extends GSBaseTable<GSUploadData> {
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
  List<GSUploadData> rows;

  GSUploadTable({
    required this.tableKey,
    required this.tableName,
    required this.lastUpdateTime,
    this.rows = const [],
  });

  @override
  GSUploadTable copyWith({
    int? tableKey,
    String? tableName,
    DateTime? lastUpdateTime,
    List<GSUploadData>? rows,
  }) => GSUploadTable(
    tableKey: tableKey ?? this.tableKey,
    tableName: tableName ?? this.tableName,
    lastUpdateTime: lastUpdateTime ?? this.lastUpdateTime,
    rows: rows ?? this.rows,
  );

  @override
  GSUploadData createRowData(
    int index,
    Map<String, dynamic> data, [
    Map<String, String>? files,
  ]) {
    return GSUploadData(index: index, data: data, files: files);
  }

  @override
  Future<void> saveTable() async {
    final table = Tables.uploadTable;
    await table.put(tableKey, this);
  }

  int get notUploadedRows => rows.where((row) => !row.uploaded).length;
}

@HiveType(typeId: CategoryType.uploadData)
class GSUploadData extends GSBaseData {
  @override
  @HiveField(0)
  int index;

  @HiveField(1)
  bool uploaded;

  @override
  @HiveField(2)
  Map<String, dynamic>? data;

  @HiveField(3)
  Map<String, String>? files;

  @HiveField(4)
  DateTime? uploadTryTime;

  @HiveField(5)
  String? uploadError;

  GSUploadData({
    required this.index,
    this.uploaded = false,
    this.data,
    this.files,
    this.uploadTryTime,
    this.uploadError,
  });

  GSUploadData copyWith({
    int? index,
    bool? uploaded,
    Map<String, dynamic>? data,
    Map<String, String>? files,
    DateTime? uploadTryTime,
    String? uploadError,
  }) => GSUploadData(
    index: index ?? this.index,
    uploaded: uploaded ?? this.uploaded,
    data: data ?? this.data,
    files: files ?? this.files,
    uploadTryTime: uploadTryTime ?? this.uploadTryTime,
    uploadError: uploadError ?? this.uploadError,
  );

  bool get notTried => !uploaded && uploadError == null;

  bool get failedUpload => !uploaded && uploadError != null;
}
