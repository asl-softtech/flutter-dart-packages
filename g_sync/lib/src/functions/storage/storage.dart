import 'package:flutter/foundation.dart';
import 'package:g_sync/src/core/constants/category.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../../core/exceptions/exceptions.dart';
import '../../core/logger/logger.dart';
import '../objects/objects.dart';

class Storage {
  const Storage._();

  static Future<void> createInstance(String packageName) async {
    try {
      final appDir = await _createDirectory(packageName);
      await _createStorage(appDir);
    } catch (_) {
      rethrow;
    }
  }

  static Future<GSAppDir?> _createDirectory(String packageName) async {
    if (kIsWeb) return null;

    try {
      final dir = await getApplicationDocumentsDirectory();
      final appDir = GSAppDir.define(
        p.join(dir.path, '.$packageName', '.gomu_gomu_sync'),
      );

      await appDir.create();
      return appDir;
    } catch (_) {
      rethrow;
    }
  }

  static Future<void> _createStorage(GSAppDir? appDir) async {
    try {
      await Hive.initFlutter(kIsWeb ? null : appDir?.db.path);
      await _registerTableAdapters();
      await _openTables();
    } catch (e, s) {
      Logger.error("Failed to create storage: $e", stackTrace: s);
      throw StorageCreationError(message: "$e");
    }
  }

  static Future<void> _registerTableAdapters() async {
    void safeRegister<T>(TypeAdapter<T> adapter) {
      if (!Hive.isAdapterRegistered(adapter.typeId)) {
        Hive.registerAdapter(adapter);
      }
    }

    safeRegister(GSDownloadDataAdapter());
    safeRegister(GSDownloadTableAdapter());
    safeRegister(GSUploadDataAdapter());
    safeRegister(GSUploadTableAdapter());
  }

  static Future<void> _openTables() async {
    await Hive.openBox<GSDownloadData>(CategoryName.downloadData);
    await Hive.openBox<GSDownloadTable>(CategoryName.downloadTable);
    await Hive.openBox<GSUploadData>(CategoryName.uploadData);
    await Hive.openBox<GSUploadTable>(CategoryName.uploadTable);
  }
}
