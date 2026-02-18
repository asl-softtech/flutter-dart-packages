# g_sync

A powerful Mass Data Transaction (MDT) package for Flutter and Dart. `g_sync` provides an offline-first synchronization layer using Hive, supporting complex data syncing, file handling, and network requests.

## Features

- **Offline-First**: Save data locally and sync when online.
- **Mass Data Sync**: Efficiently download and upload large datasets.
- **File Support**: Synchronize files alongside data rows.
- **Flexible Network Support**: Supports GET, POST, PUT, and DELETE methods.
- **Storage-agnostic**: Built on top of `hive_ce` for high-performance local storage.

## Installation

Add `g_sync` to your `pubspec.yaml`:

```yaml
dependencies:
  g_sync: ^0.0.1
```

Then run:

```bash
flutter pub get
```

## Getting Started

### Initialization

Before using any synchronization features, initialize the package:

```dart
import 'package:g_sync/g_sync.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GomuGomuSync.init('com.your.app.id');
  runApp(MyApp());
}
```

## API Structure

### GomuGomuSync

The main entry point for all operations.

#### Methods:

- `init([String? package])`: Initializes the internal storage.
- `saveToTable({required GSTable table, required Map<String, dynamic> data, Map<String, String>? files})`: Saves data for synchronization.
- `download({required List<GSDownloadParams> tableWiseParams})`: Triggers a mass download.
- `upload({required List<GSUploadParams> unuploadedRows})`: Triggers a mass upload.
- `getDataFormTable({required GSTable table})`: Retrieves data from a specific table.
- `getNotUploadedData({required List<GSTable> tables})`: Returns rows pending upload.

### Models

- **GSTable**: Configuration for a table (ID, name, URL, method, type).
- **GSDownloadParams**: Parameters for downloading data to a specific table.
- **GSUploadParams**: Parameters for uploading local data.
- **GSData**: Base class for data structures.

## Usage Example

### Saving data for later upload

```dart
await GomuGomuSync.saveToTable(
  table: myUploadTable,
  data: {
    'id': 1,
    'name': 'Sample Data',
  },
  files: {
    'image': '/path/to/local/image.jpg',
  },
);
```

### Performing a Sync

```dart
// Upload pending data
final pendingData = await GomuGomuSync.getNotUploadedData([myUploadTable]);
await GomuGomuSync.upload(pendingData);

// Download fresh data
await GomuGomuSync.download([
  GSDownloadParams(table: myDownloadTable, params: {'user_id': 123}),
]);
```

## Additional Information

- **Repository**: [GitHub](https://github.com/asl-softtech/flutter-dart-packages/tree/main/g_sync)
- **Issues**: Please file issues on the repository's issue tracker.
- **License**: MIT
