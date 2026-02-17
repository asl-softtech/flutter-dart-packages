import 'objects/objects.dart';
import 'storage/storage.dart';
import 'storage/storage_functions.dart';

class GomuGomuSync {
  const GomuGomuSync._();

  static Future<void> init([String? package]) async {
    return await Storage.createInstance(
      package ?? "com.asl.app.gomu_gomu_sync",
    );
  }

  static Future<void> clearAllTables() async {
    return await StorageFunctions.clearAllTable();
  }

  static Future<void> deleteARowFromTable({
    required GSTable table,
    required int rowIndex,
  }) async {
    return await StorageFunctions.deleteARowFromTable(table, rowIndex);
  }

  static Future<void> download({
    required List<GSDownloadParams> tableWiseParams,
  }) async {
    return await StorageFunctions.download(tableWiseParams);
  }

  static Future<List<Map<String, dynamic>>> getDataFormTable({
    required GSTable table,
  }) async {
    return await StorageFunctions.getDataFormTable(table);
  }

  static Future<List<GSData>> getDownloadTables() async {
    return await StorageFunctions.getDownloadTables();
  }

  static Future<List<GSData>> getUploadTables() async {
    return await StorageFunctions.getUploadTables();
  }

  static Future<List<GSUploadTable>> getNotUploadedData({
    required List<GSTable> tables,
  }) async {
    return await StorageFunctions.getNotUploadedData(tables);
  }

  static Future<void> saveToTable({
    required GSTable table,
    required Map<String, dynamic> data,
    Map<String, String>? files,
  }) async {
    return await StorageFunctions.saveToTable(table, data, files);
  }

  static Future<void> upload({
    required List<GSUploadParams> unuploadedRows,
  }) async {
    return await StorageFunctions.upload(unuploadedRows);
  }
}
