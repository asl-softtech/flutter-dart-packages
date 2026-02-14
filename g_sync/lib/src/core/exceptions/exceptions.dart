import '../constants/errors.dart';

class GSErrors implements Exception {
  final String code;
  final String message;

  GSErrors({required this.code, required this.message});

  @override
  String toString() {
    return "[$code] $message";
  }
}

final class NetworkError extends GSErrors {
  NetworkError()
    : super(code: no_network_error, message: "No internet connection");
}

final class TableNotFoundError extends GSErrors {
  final String tableName;
  final String? msg;
  TableNotFoundError({required this.tableName, this.msg})
    : super(code: table_not_found, message: "[$tableName] : ${msg ?? "Table not found"}");
}

final class RowNotFoundError extends GSErrors {
  RowNotFoundError() : super(code: row_not_found, message: "Row not found");
}

final class ServerError extends GSErrors {
  ServerError() : super(code: server_error, message: "Server error");
}

final class InstanceCreateError extends GSErrors {
  InstanceCreateError({required super.message})
    : super(code: instance_create_error);
}

final class StorageCreationError extends GSErrors {
  StorageCreationError({required super.message})
    : super(code: storage_creation_error);
}

final class NotInitialized extends GSErrors {
  NotInitialized({required super.message}) : super(code: not_initialized);
}
