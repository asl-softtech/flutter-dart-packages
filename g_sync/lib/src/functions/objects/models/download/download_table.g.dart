// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'download_table.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GSDownloadTableAdapter extends TypeAdapter<GSDownloadTable> {
  @override
  final typeId = 5002;

  @override
  GSDownloadTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GSDownloadTable(
      tableKey: (fields[0] as num).toInt(),
      tableName: fields[1] as String,
      lastUpdateTime: fields[2] as DateTime,
      rows: fields[3] == null
          ? const []
          : (fields[3] as List).cast<GSDownloadData>(),
    );
  }

  @override
  void write(BinaryWriter writer, GSDownloadTable obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.tableKey)
      ..writeByte(1)
      ..write(obj.tableName)
      ..writeByte(2)
      ..write(obj.lastUpdateTime)
      ..writeByte(3)
      ..write(obj.rows);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GSDownloadTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GSDownloadDataAdapter extends TypeAdapter<GSDownloadData> {
  @override
  final typeId = 5001;

  @override
  GSDownloadData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GSDownloadData(
      index: (fields[0] as num).toInt(),
      data: (fields[1] as Map?)?.cast<String, dynamic>(),
    );
  }

  @override
  void write(BinaryWriter writer, GSDownloadData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.index)
      ..writeByte(1)
      ..write(obj.data);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GSDownloadDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
