import 'dart:convert';

class GSNetworkResponse {
  bool success;

  int statusCode;

  String? errorMessage;

  GSPagination? pagination;

  dynamic data;

  GSNetworkResponse({
    required this.success,
    required this.statusCode,
    this.errorMessage,
    this.pagination,
    this.data,
  });

  factory GSNetworkResponse.fromRawJson(String str) =>
      GSNetworkResponse.fromJson(json.decode(str));

  factory GSNetworkResponse.fromJson(Map<String, dynamic> json) =>
      GSNetworkResponse(
        success: _isSuccessful(json['success'] ?? json['status']),
        statusCode: json['status_code'] ?? json['code'] ?? 0,
        errorMessage: _generateErrorMessage(json),
        data: json['data'],
        pagination: json['pagination'] != null
            ? GSPagination.fromJson(json['pagination'])
            : null,
      );

  static String? _generateErrorMessage(Map<String, dynamic> json) {
    const keys = ['message', 'error', 'errors', 'error_message'];

    final parts = <String>[];
    for (final key in keys) {
      final part = _stringify(json[key]);
      if (part != null && part.isNotEmpty) {
        parts.add(part);
      }
    }

    return parts.isEmpty ? null : parts.join(', ');
  }

  static String? _stringify(dynamic value) {
    if (value is String) {
      return value;
    } else if (value is List) {
      return value.map(_stringify).whereType<String>().join(', ');
    } else if (value is Map) {
      return value.values.map(_stringify).whereType<String>().join(', ');
    } else {
      return null;
    }
  }

  static bool _isSuccessful(dynamic json) {
    if (json is String) {
      return json.toLowerCase() == 'true';
    } else if (json is int) {
      return json == 1;
    } else if (json is bool) {
      return json;
    } else {
      return false;
    }
  }

  GSNetworkResponse copyWith({
    bool? success,
    int? statusCode,
    String? errorMessage,
    GSPagination? pagination,
    dynamic data,
  }) => GSNetworkResponse(
    success: success ?? this.success,
    statusCode: statusCode ?? this.statusCode,
    errorMessage: errorMessage ?? this.errorMessage,
    pagination: pagination ?? this.pagination,
    data: data ?? this.data,
  );

  @override
  String toString() {
    var str =
        """
  NetworkResponse(
    success: $success,
    statusCode: $statusCode,
  """;
    if (errorMessage != null) {
      str +=
          """
    errorMessage: $errorMessage,
  """;
    }

    if (pagination != null) {
      str +=
          """
    pagination: $pagination,
  """;
    }

    if (data != null) {
      str +=
          """
    data: $data,
  """;
    }

    str += """
    )
    """;

    return str;
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "status_code": statusCode,
    if (errorMessage != null) "error_message": errorMessage,
    if (pagination != null) "pagination": pagination?.toJson(),
    if (data != null) "data": data,
  };

  String toRawJson() => json.encode(toJson());
}

class GSPagination {
  int? currentPage;

  int? perPage;

  int? total;

  int? lastPage;

  GSPagination({this.currentPage, this.perPage, this.total, this.lastPage});

  factory GSPagination.fromRawJson(String str) =>
      GSPagination.fromJson(json.decode(str));

  factory GSPagination.fromJson(Map<String, dynamic> json) => GSPagination(
    currentPage: json["current_page"],
    perPage: json["per_page"],
    total: json["total"],
    lastPage: json["last_page"],
  );

  GSPagination copyWith({
    int? currentPage,
    int? perPage,
    int? total,
    int? lastPage,
  }) => GSPagination(
    currentPage: currentPage ?? this.currentPage,
    perPage: perPage ?? this.perPage,
    total: total ?? this.total,
    lastPage: lastPage ?? this.lastPage,
  );

  @override
  String toString() =>
      'GSPagination(currentPage: $currentPage, perPage: $perPage, total: $total, lastPage: $lastPage)';

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "per_page": perPage,
    "total": total,
    "last_page": lastPage,
  };

  String toRawJson() => json.encode(toJson());
}
