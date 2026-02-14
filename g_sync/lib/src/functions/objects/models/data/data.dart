abstract class GSData<T> {
  final String tableName;

  final int tableID;

  final List<T> tableRows;

  GSData({
    required this.tableName,
    required this.tableID,
    required this.tableRows,
  });
}
