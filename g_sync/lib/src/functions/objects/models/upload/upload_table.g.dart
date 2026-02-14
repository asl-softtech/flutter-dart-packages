// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_table.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GSUploadTableAdapter extends TypeAdapter<GSUploadTable> {
  @override
  final typeId = 5004;

  @override
  GSUploadTable read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GSUploadTable(
      tableKey: (fields[0] as num).toInt(),
      tableName: fields[1] as String,
      lastUpdateTime: fields[2] as DateTime,
      rows: fields[3] == null
          ? const []
          : (fields[3] as List).cast<GSUploadData>(),
    );
  }

  @override
  void write(BinaryWriter writer, GSUploadTable obj) {
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
      other is GSUploadTableAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GSUploadDataAdapter extends TypeAdapter<GSUploadData> {
  @override
  final typeId = 5003;

  @override
  GSUploadData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GSUploadData(
      index: (fields[0] as num).toInt(),
      uploaded: fields[1] == null ? false : fields[1] as bool,
      data: (fields[2] as Map?)?.cast<String, dynamic>(),
      files: (fields[3] as Map?)?.cast<String, String>(),
      uploadTryTime: fields[4] as DateTime?,
      uploadError: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, GSUploadData obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.index)
      ..writeByte(1)
      ..write(obj.uploaded)
      ..writeByte(2)
      ..write(obj.data)
      ..writeByte(3)
      ..write(obj.files)
      ..writeByte(4)
      ..write(obj.uploadTryTime)
      ..writeByte(5)
      ..write(obj.uploadError);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GSUploadDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
