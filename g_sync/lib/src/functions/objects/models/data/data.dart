// Copyright (c) 2026 ASL Softtech. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

/// Base class for synchronization data.
abstract class GSData<T> {
  /// The name of the table associated with this data.
  final String tableName;

  /// The unique identifier of the table.
  final int tableID;

  /// The collection of data objects in this table.
  final List<T> tableRows;

  /// Base constructor for [GSData].
  GSData({
    required this.tableName,
    required this.tableID,
    required this.tableRows,
  });
}
