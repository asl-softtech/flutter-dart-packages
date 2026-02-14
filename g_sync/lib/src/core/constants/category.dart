import 'package:g_sync/src/functions/objects/models/download/download_table.dart';
import 'package:hive_ce/hive.dart';

import '../../functions/objects/models/upload/upload_table.dart';

/// Centralized access to Hive boxes used in the app.
class Tables {
  static Box<GSDownloadData> get downloadData =>
      Hive.box<GSDownloadData>(CategoryName.downloadData);

  static Box<GSDownloadTable> get downloadTable =>
      Hive.box<GSDownloadTable>(CategoryName.downloadTable);

  static Box<GSUploadData> get uploadData =>
      Hive.box<GSUploadData>(CategoryName.uploadData);

  static Box<GSUploadTable> get uploadTable =>
      Hive.box<GSUploadTable>(CategoryName.uploadTable);
}

/// Hive type IDs for different stored objects.
///
/// These IDs are used by Hive to identify the type when reading/writing objects.
class CategoryType {
  static const int downloadData = 5001;
  static const int downloadTable = 5002;
  static const int uploadData = 5003;
  static const int uploadTable = 5004;
}

/// Standardized Hive box names used throughout the app.
class CategoryName {
  static const String downloadData = "downloadData";
  static const String downloadTable = "downloadTable";
  static const String uploadData = "uploadData";
  static const String uploadTable = "uploadTable";
}
