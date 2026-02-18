// Copyright (c) 2026 ASL Softtech. All rights reserved.
// Use of this source code is governed by an MIT-style license that can be
// found in the LICENSE file.

import 'package:g_sync/src/functions/objects/enum/table_types.dart';

import '../../enum/network_methode.dart';

/// Represents a table configuration for synchronization.
class GSTable {
  /// Unique identifier for the table.
  final int id;

  /// The name of the table in local storage.
  final String tableName;

  /// The endpoint URL used for synchronization.
  final String urlToHeat;

  /// The HTTP method used to access the [urlToHeat].
  final GSNetworkMethode methode;

  /// The type of table (upload or download).
  final GSTableTypes tableType;

  /// Creates a new [GSTable] instance.
  GSTable({
    required this.id,
    required this.tableName,
    required this.urlToHeat,
    required this.methode,
    required this.tableType,
  });
}
