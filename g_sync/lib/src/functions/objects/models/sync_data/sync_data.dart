/// Generic wrapper representing a table and its data for Offline Sync.
///
/// [k] is the type of data stored in the table, e.g., [OSUploadData], [OSDownloadData], or [OSFileTable].
class GSyncData<k> {
  /// Name of the offline sync table.
  final String tableName;

  /// Unique identifier of the table.
  final int tableId;

  /// List of data rows contained in the table.
  final List<k> tableData;

  /// Creates a new instance of [GSyncData].
  ///
  /// All fields are required.
  GSyncData({
    required this.tableName,
    required this.tableData,
    required this.tableId,
  });
}