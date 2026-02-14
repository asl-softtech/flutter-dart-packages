import '../../objects.dart';

class GSUploadParams {
  final GSTable table;
  final GSUploadData notUploadedRow;
  final Map<String, String>? headerData;
  final Map<String, dynamic>? queryParamsData;

  GSUploadParams({
    required this.table,
    required this.notUploadedRow,
    this.headerData,
    this.queryParamsData,
  });
}
