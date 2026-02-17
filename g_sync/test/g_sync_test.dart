import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:g_sync/src/core/constants/category.dart';
import 'package:g_sync/src/functions/objects/enum/network_methode.dart';
import 'package:g_sync/src/functions/objects/enum/table_types.dart';
import 'package:g_sync/src/functions/objects/models/download/download_table.dart';
import 'package:g_sync/src/functions/objects/models/response/response.dart';
import 'package:g_sync/src/functions/objects/models/table/table.dart';
import 'package:g_sync/src/functions/objects/models/upload/upload_table.dart';
import 'package:g_sync/src/functions/storage/storage_functions.dart';
import 'package:g_sync/src/core/exceptions/exceptions.dart';
import 'package:hive_ce/hive.dart';

void main() {
  late Directory tempDir;

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    tempDir = await Directory.systemTemp.createTemp();
    Hive.init(tempDir.path);
    Hive.registerAdapter(GSDownloadDataAdapter());
    Hive.registerAdapter(GSDownloadTableAdapter());
    Hive.registerAdapter(GSUploadDataAdapter());
    Hive.registerAdapter(GSUploadTableAdapter());
  });

  tearDownAll(() async {
    await tempDir.delete(recursive: true);
  });

  setUp(() async {
    await Hive.openBox<GSDownloadData>(CategoryName.downloadData);
    await Hive.openBox<GSDownloadTable>(CategoryName.downloadTable);
    await Hive.openBox<GSUploadData>(CategoryName.uploadData);
    await Hive.openBox<GSUploadTable>(CategoryName.uploadTable);
  });

  tearDown(() async {
    await Hive.deleteFromDisk();
  });

  group('GSNetworkResponse Tests', () {
    test('GSNetworkResponse.fromJson handles true success', () {
      final json = {'success': true, 'status_code': 200, 'data': 'test'};
      final response = GSNetworkResponse.fromJson(json);
      expect(response.success, isTrue);
      expect(response.statusCode, 200);
      expect(response.data, 'test');
    });

    test('GSNetworkResponse.fromJson handles "true" string success', () {
      final json = {'success': 'true', 'status_code': 200};
      final response = GSNetworkResponse.fromJson(json);
      expect(response.success, isTrue);
    });

    test('GSNetworkResponse.fromJson handles 1 int success', () {
      final json = {'success': 1, 'status_code': 200};
      final response = GSNetworkResponse.fromJson(json);
      expect(response.success, isTrue);
    });

    test('GSNetworkResponse.fromJson handles "status" key for success', () {
      final json = {'status': true, 'status_code': 200};
      final response = GSNetworkResponse.fromJson(json);
      expect(response.success, isTrue);
    });

    test('GSNetworkResponse.fromJson handles error messages', () {
      final json = {
        'success': false,
        'status_code': 400,
        'message': 'Error Message',
      };
      final response = GSNetworkResponse.fromJson(json);
      expect(response.success, isFalse);
      expect(response.errorMessage, 'Error Message');
    });

    test('GSNetworkResponse.fromJson handles list error messages', () {
      final json = {
        'success': false,
        'status_code': 400,
        'errors': ['Error 1', 'Error 2'],
      };
      final response = GSNetworkResponse.fromJson(json);
      expect(response.errorMessage, 'Error 1, Error 2');
    });
  });

  group('GSTable Tests', () {
    test('GSTable instantiation', () {
      final table = GSTable(
        id: 1,
        tableName: 'test_table',
        urlToHeat: 'https://example.com/api',
        methode: GSNetworkMethode.post,
        tableType: GSTableTypes.uploadTable,
      );

      expect(table.id, 1);
      expect(table.tableName, 'test_table');
      expect(table.urlToHeat, 'https://example.com/api');
      expect(table.methode, GSNetworkMethode.post);
      expect(table.tableType, GSTableTypes.uploadTable);
    });
  });

  group('StorageFunctions Tests', () {
    final uploadTable = GSTable(
      id: 1,
      tableName: 'upload_table',
      urlToHeat: 'https://example.com',
      methode: GSNetworkMethode.post,
      tableType: GSTableTypes.uploadTable,
    );

    final downloadTable = GSTable(
      id: 2,
      tableName: 'download_table',
      urlToHeat: 'https://example.com',
      methode: GSNetworkMethode.get,
      tableType: GSTableTypes.downloadTable,
    );

    test('saveToTable and getDataFormTable for upload table', () async {
      final data = {'name': 'test', 'value': 123};
      await StorageFunctions.saveToTable(uploadTable, data);

      final retrievedData = await StorageFunctions.getDataFormTable(
        uploadTable,
      );
      expect(retrievedData.length, 1);
      expect(retrievedData.first['name'], 'test');
      expect(retrievedData.first['value'], 123);
    });

    test('saveToTable and getDataFormTable for download table', () async {
      final data = {'key': 'val'};
      await StorageFunctions.saveToTable(downloadTable, data);

      final retrievedData = await StorageFunctions.getDataFormTable(
        downloadTable,
      );
      expect(retrievedData.length, 1);
      expect(retrievedData.first['key'], 'val');
    });

    test('deleteARowFromTable', () async {
      await StorageFunctions.saveToTable(uploadTable, {'a': 1});
      await StorageFunctions.saveToTable(uploadTable, {'b': 2});

      var data = await StorageFunctions.getDataFormTable(uploadTable);
      expect(data.length, 2);

      await StorageFunctions.deleteARowFromTable(uploadTable, 1);

      data = await StorageFunctions.getDataFormTable(uploadTable);
      expect(data.length, 1);
      expect(data.first['b'], 2);
    });

    test('clearAllTable', () async {
      await StorageFunctions.saveToTable(uploadTable, {'a': 1});
      await StorageFunctions.saveToTable(downloadTable, {'b': 2});

      await StorageFunctions.clearAllTable();

      expect(
        () => StorageFunctions.getDataFormTable(uploadTable),
        throwsA(isA<TableNotFoundError>()),
      );
      expect(
        () => StorageFunctions.getDataFormTable(downloadTable),
        throwsA(isA<TableNotFoundError>()),
      );
    });
  });
}
