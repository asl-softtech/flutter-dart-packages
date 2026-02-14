import 'package:g_sync/src/functions/objects/enum/table_types.dart';

import '../../enum/network_methode.dart';

class GSTable {
  final int id;
  final String tableName;
  final String urlToHeat;
  final GSNetworkMethode methode;
  final GSTableTypes tableType;

  GSTable({
    required this.id,
    required this.tableName,
    required this.urlToHeat,
    required this.methode,
    required this.tableType,
  });
}
