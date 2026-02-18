// Copyright (c) 2026 ASL Softtech. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import 'objects/objects.dart';
import 'storage/storage.dart';
import 'storage/storage_functions.dart';

/// The primary entry point for the GomuGomuSync package.
///
/// This class provides static methods to initialize the storage,
/// manage tables, and synchronize data between local storage and remote servers.
class GomuGomuSync {
  const GomuGomuSync._();

  /// Initializes the tracking and storage for the package.
  ///
  /// The [package] parameter is optional and defaults to "com.asl.app.gomu_gomu_sync".
  /// This must be called before any other methods in this class.
  static Future<void> init([String? package]) async {
    return await Storage.createInstance(
      package ?? "com.asl.app.gomu_gomu_sync",
    );
  }

  /// Clears all tables in the local storage.
  ///
  /// Use this with caution as it will delete all locally cached data.
  static Future<void> clearAllTables() async {
    return await StorageFunctions.clearAllTable();
  }

  /// Deletes a specific row index from the given [table].
  static Future<void> deleteARowFromTable({
    required GSTable table,
    required int rowIndex,
  }) async {
    return await StorageFunctions.deleteARowFromTable(table, rowIndex);
  }

  /// Downloads data from remote servers based on the provided [tableWiseParams].
  ///
  /// Each [GSDownloadParams] defines the target table and its specific parameters.
  static Future<void> download({
    required List<GSDownloadParams> tableWiseParams,
  }) async {
    return await StorageFunctions.download(tableWiseParams);
  }

  /// Retrieves all data from the specified [table] as a list of maps.
  static Future<List<Map<String, dynamic>>> getDataFormTable({
    required GSTable table,
  }) async {
    return await StorageFunctions.getDataFormTable(table);
  }

  /// Gets a list of data models for all download-enabled tables.
  static Future<List<GSData>> getDownloadTables() async {
    return await StorageFunctions.getDownloadTables();
  }

  /// Gets a list of data models for all upload-enabled tables.
  static Future<List<GSData>> getUploadTables() async {
    return await StorageFunctions.getUploadTables();
  }

  /// Retrieves data that has not yet been uploaded for the specified [tables].
  static Future<List<GSUploadTable>> getNotUploadedData({
    required List<GSTable> tables,
  }) async {
    return await StorageFunctions.getNotUploadedData(tables);
  }

  /// Saves a row of [data] and optional [files] to the specified [table].
  static Future<void> saveToTable({
    required GSTable table,
    required Map<String, dynamic> data,
    Map<String, String>? files,
  }) async {
    return await StorageFunctions.saveToTable(table, data, files);
  }

  /// Uploads the specified [unuploadedRows] to the remote server.
  static Future<void> upload({
    required List<GSUploadParams> unuploadedRows,
  }) async {
    return await StorageFunctions.upload(unuploadedRows);
  }
}
