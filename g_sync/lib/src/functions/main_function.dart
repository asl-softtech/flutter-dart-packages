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
}
