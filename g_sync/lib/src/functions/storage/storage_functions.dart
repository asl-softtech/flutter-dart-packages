import 'dart:io';

import 'package:g_sync/src/core/exceptions/exceptions.dart';
import 'package:g_sync/src/core/extensions/extensions.dart';

import '../../core/constants/category.dart';
import '../../core/logger/logger.dart';
import '../network/network.dart';
import '../objects/models/response/response.dart';
import '../objects/models/tables.dart';
import '../objects/objects.dart';

class StorageFunctions {
  const StorageFunctions._();

  Future<void> clearAllTable() async {
    try {
      await Future.wait([
        Tables.downloadTable.clear(),
        Tables.uploadTable.clear(),
      ]);
    } catch (e) {
      throw GSErrors(code: "clearAllTable".snakeCase, message: e.toString());
    }
  }

  Future<void> deleteARowFromTable(GSTable table, int rowIndex) async {
    try {
      if (table.tableType == GSTableTypes.downloadTable) {
        final tableInstance = Tables.downloadTable.get(table.id);
        if (tableInstance == null) {
          throw TableNotFoundError(tableName: table.tableName);
        }

        final index = tableInstance.rows.indexWhere((e) => e.index == rowIndex);

        if (index == -1) {
          throw RowNotFoundError();
        }

        tableInstance.rows.removeAt(index);
        await tableInstance.saveTable();
      } else if (table.tableType == GSTableTypes.uploadTable) {
        final tableInstance = Tables.uploadTable.get(table.id);
        if (tableInstance == null) {
          throw TableNotFoundError(tableName: table.tableName);
        }

        final index = tableInstance.rows.indexWhere((e) => e.index == rowIndex);

        if (index == -1) {
          throw RowNotFoundError();
        }

        tableInstance.rows.removeAt(index);
        await tableInstance.saveTable();
      }
    } catch (_) {
      rethrow;
    }
  }

  Future<void> download(List<GSDownloadParams> tableWiseParams) async {
    try {
      final startTime = DateTime.now();

      final initialized = Tables.downloadTable.isOpen;
      if (!initialized) {
        throw NotInitialized(message: "DownloadTables are not initialized");
      }

      Logger.plain("Download Started at: ${startTime.toTimeString12}");

      for (final params in tableWiseParams) {
        final table = params.table;

        Logger.plain("Fetching data from ${table.tableName}");

        final response = await GSNetwork.request(
          table.urlToHeat,
          table.methode.methode,
          headers: params.headerData,
          query: params.queryParamsData,
          body: params.bodyData,
        );

        final networkResponse = GSNetworkResponse.fromJson(response);

        if (!networkResponse.success || networkResponse.data is! List) {
          Logger.warning(
            "No valid data received for table: ${table.tableName}",
          );
          continue;
        }

        final responseData = networkResponse.data as List;

        final List<GSDownloadData> rows = responseData
            .asMap()
            .entries
            .map(
              (entry) =>
                  GSDownloadData(index: entry.key + 1, data: entry.value),
            )
            .toList();

        final storageTable = GSDownloadTable(
          tableKey: table.id,
          tableName: table.tableName,
          lastUpdateTime: DateTime.now(),
          rows: rows,
        );

        await storageTable.saveTable();
        Logger.plain("Total rows for table ${table.tableName}: ${rows.length}");
      }

      final endTime = DateTime.now();
      Logger.plain("Download Completed At: ${endTime.toTimeString12}");
      Logger.plain("Total time taken: ${endTime.difference(startTime)}");
    } on SocketException {
      throw NetworkError();
    } catch (_) {
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getDataFormTable(GSTable table) async {
    try {
      final storageTable = table.tableType == GSTableTypes.downloadTable
          ? Tables.downloadTable.get(table.id)
          : Tables.uploadTable.get(table.id);

      if (storageTable == null) {
        throw TableNotFoundError(tableName: table.tableName);
      }

      List<Map<String, dynamic>> rows;

      if (table.tableType == GSTableTypes.downloadTable) {
        final downloadTable = storageTable as GSDownloadTable;
        rows = downloadTable.rows
            .where((row) => row.data != null)
            .map((e) => e.data!)
            .toList();
      } else {
        final uploadTable = storageTable as GSUploadTable;
        rows = uploadTable.rows
            .where((row) => row.data != null)
            .map((e) => e.data!)
            .toList();
      }

      return rows;
    } catch (_) {
      rethrow;
    }
  }

  Future<List<GSData>> getDownloadTables() async {
    try {
      final table = Tables.downloadTable;

      final showableDataTables = table.values.toList();

      return showableDataTables
          .map(
            (t) => GSDownloadShowData(
              tableName: t.tableName,
              tableID: t.tableKey,
              tableRows: t.rows,
            ),
          )
          .toList();
    } catch (_) {
      rethrow;
    }
  }

  Future<List<GSData>> getUploadTables() async {
    try {
      final table = Tables.uploadTable;

      final showableDataTables = table.values.toList();

      return showableDataTables
          .map(
            (t) => GSUploadShowData(
              tableName: t.tableName,
              tableID: t.tableKey,
              tableRows: t.rows,
            ),
          )
          .toList();
    } catch (_) {
      rethrow;
    }
  }

  Future<List<GSUploadTable>> getNotUploadedData(List<GSTable> tables) async {
    try {
      final notUploadedTables = <GSUploadTable>[];

      for (final table in tables) {
        if (table.tableType != GSTableTypes.uploadTable) {
          Logger.warning("Not a upload table: ${table.tableName}");
          continue;
        }
        final tableInstance = Tables.uploadTable.get(table.id);
        if (tableInstance == null) {
          Logger.warning("Table not found: ${table.tableName}");
          continue;
        }

        final notUploadedRows = tableInstance.rows
            .where((row) => !row.uploaded)
            .toList();

        if (notUploadedRows.isNotEmpty) {
          notUploadedTables.add(tableInstance.copyWith(rows: notUploadedRows));
        }
      }

      return notUploadedTables;
    } catch (_) {
      rethrow;
    }
  }

  Future<void> saveToTable(
      GSTable table,
      Map<String, dynamic> data, [
        Map<String, String>? files,
      ]) async {
    final isDownload = table.tableType == GSTableTypes.downloadTable;
    final isUpload = table.tableType == GSTableTypes.uploadTable;

    if (!isDownload && !isUpload) {
      throw TableNotFoundError(
        tableName: table.tableName,
        msg: "Invalid table type",
      );
    }

    GSBaseTable tableInstance;

    if (isDownload) {
      tableInstance = Tables.downloadTable.get(table.id) ??
          GSDownloadTable(
            tableKey: table.id,
            tableName: table.tableName,
            lastUpdateTime: DateTime.now(),
          );
    } else {
      tableInstance = Tables.uploadTable.get(table.id) ??
          GSUploadTable(
            tableKey: table.id,
            tableName: table.tableName,
            lastUpdateTime: DateTime.now(),
          );
    }

    final nextIndex = tableInstance.rows.isEmpty ? 1 : tableInstance.rows.last.index + 1;
    final newRow = tableInstance.createRowData(nextIndex, data, files);

    tableInstance = tableInstance.copyWith(
      rows: [...tableInstance.rows, newRow],
      lastUpdateTime: DateTime.now(),
    );

    await tableInstance.saveTable();
    Logger.plain("Data saved to ${table.tableName} at row: $nextIndex");
  }
}
