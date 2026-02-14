enum GSTableTypes {
  /// Table containing data to be uploaded to the server.
  uploadTable,

  /// Table containing data downloaded from the server.
  downloadTable,

  /// Represents no table type or an uninitialized state.
  none,
}

/// Extension providing helper methods for [GSTableTypes].
extension GSTableTypesExt on GSTableTypes {
  /// Returns the enum value as a simple string without the enum class prefix.
  String get name => toString().split('.').last;

  /// Returns `true` if this is an upload table.
  bool get isUpload => this == GSTableTypes.uploadTable;

  /// Returns `true` if this is a download table.
  bool get isDownload => this == GSTableTypes.downloadTable;

  /// Returns `true` if this represents no table type.
  bool get isNone => this == GSTableTypes.none;
}