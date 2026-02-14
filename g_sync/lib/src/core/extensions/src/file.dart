part of '../extensions.dart';

extension FileExtGS on File {
  /// Returns the file name (last part of the path).
  String get name => path.split('/').last;

  /// Returns the file extension without the dot, e.g., `jpg`, `pdf`.
  String get fileType => path.split('.').last;

  /// Returns the file size in a human-readable format (B, KB, MB, GB, TB).
  String get realSize {
    final bytes = lengthSync();
    if (bytes <= 0) return "0 B";

    const suffixes = ["B", "KB", "MB", "GB", "TB"];
    int i = (bytes == 0) ? 0 : (bytes.bitLength / 10).floor();

    double size = bytes / (1 << (10 * i));
    return "${size.toStringAsFixed(2)} ${suffixes[i]}";
  }

  /// Returns the lowercase file extension using the `path` package.
  String get type {
    return p.extension(path).replaceFirst('.', '').toLowerCase();
  }

  /// Categorizes the file based on its extension.
  ///
  /// Categories include: `Image`, `Video`, `Audio`, `Document`, `Archive`, or `Other`.
  String get category {
    final ext = type;

    const imageExt = [
      'png',
      'jpg',
      'jpeg',
      'gif',
      'bmp',
      'webp',
      'tiff',
      'heic',
    ];
    const videoExt = ['mp4', 'mov', 'avi', 'mkv', 'flv', 'wmv', 'webm'];
    const audioExt = ['mp3', 'wav', 'aac', 'flac', 'ogg', 'm4a'];
    const docExt = [
      'pdf',
      'doc',
      'docx',
      'xls',
      'xlsx',
      'ppt',
      'pptx',
      'txt',
      'rtf',
      'md',
    ];
    const archiveExt = ['zip', 'rar', '7z', 'tar', 'gz'];

    if (imageExt.contains(ext)) return "Image";
    if (videoExt.contains(ext)) return "Video";
    if (audioExt.contains(ext)) return "Audio";
    if (docExt.contains(ext)) return "Document";
    if (archiveExt.contains(ext)) return "Archive";

    return "Other";
  }
}
