import 'package:g_sync/src/functions/objects/objects.dart';

class GSDownloadParams {
  final GSTable table;
  final Map<String, String>? headerData;
  final Map<String, dynamic>? queryParamsData;
  final Map<String, dynamic>? bodyData;

  GSDownloadParams({
    required this.table,
    this.headerData,
    this.queryParamsData,
    this.bodyData,
  });
}
