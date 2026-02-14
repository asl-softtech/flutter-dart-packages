part of '../extensions.dart';

extension MapExtGS on Map {
  /// Returns a pretty-printed JSON string representation of the map.
  ///
  /// If the map is empty, returns `"{}"`.
  /// Base64 encoded strings are replaced with "base64 File Type" for readability.
  /// In case of an error during encoding, logs the error and returns `"{}"`.
  ///
  /// Example:
  /// ```dart
  /// final map = {'name': 'Alice', 'age': 25};
  /// print(map.toBeautifiedString);
  /// ```
  /// Output:
  /// ```json
  /// {
  ///     "name": "Alice",
  ///     "age": 25
  /// }
  /// ```
  String get toBeautifiedString {
    if (isEmpty) return "{}";

    try {
      final sanitized = _sanitizeBase64Values(this);
      const JsonEncoder encoder = JsonEncoder.withIndent('    ');
      return encoder.convert(sanitized);
    } catch (e) {
      Logger.error("$e");
      return "{}";
    }
  }

  /// Recursively sanitizes base64 strings in the map structure
  dynamic _sanitizeBase64Values(dynamic value) {
    if (value is Map) {
      return value.map((key, val) => MapEntry(key, _sanitizeBase64Values(val)));
    } else if (value is List) {
      return value.map((item) => _sanitizeBase64Values(item)).toList();
    } else if (value is String && _isBase64String(value)) {
      return "base64 String";
    }
    return value;
  }

  /// Checks if a string appears to be base64 encoded
  bool _isBase64String(String str) {
    // Skip short strings (base64 files are typically long)
    if (str.length < 100) return false;

    // Check for base64 pattern (alphanumeric + / + =)
    final base64Pattern = RegExp(r'^[A-Za-z0-9+/]*={0,2}$');
    return base64Pattern.hasMatch(str);
  }
}