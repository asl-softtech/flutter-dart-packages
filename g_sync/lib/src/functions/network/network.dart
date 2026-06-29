import 'dart:convert';
import 'dart:io';

import 'package:g_sync/src/core/extensions/extensions.dart';
import 'package:http/http.dart' as http;

import '../../core/exceptions/exceptions.dart';
import '../../core/logger/logger.dart';
import '../objects/models/response/response.dart';

class GSNetwork {
  const GSNetwork._();

  static Future<Map<String, dynamic>> request(
    String url,
    String method, {
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Map<String, dynamic>? body,
    Map<String, String>? files,
    bool showFullLog = false,
    bool showLog = true,
  }) async {
    Map<String, dynamic> response;

    if (files != null && files.isNotEmpty) {
      response = await _fileRequest(
        url,
        method,
        headers: headers,
        query: query,
        body: body,
        files: files,
      );
    } else {
      response = await _plainRequest(
        url,
        method,
        headers: headers,
        query: query,
        body: body,
      );
    }
    var log =
        """
    NETWORK REQUEST INFO
      URL: $url
      METHOD: $method
    """;

    if (showFullLog && query != null && query.isNotEmpty) {
      log +=
          """
      QUERY PARAMS: ${query.toBeautifiedString}
      """;
    }

    if (showFullLog && body != null && body.isNotEmpty) {
      log +=
          """
      REQUEST DATA: ${body.toBeautifiedString}
      """;
    }
    if (showFullLog && response.isNotEmpty) {
      log +=
          """
      RESPONSE DATA: ${response.toBeautifiedString}
      """;
    }

    if (showLog) {
      Logger.plain(log, false);
    }

    return response;
  }

  static Future<Map<String, dynamic>> _plainRequest(
    String url,
    String method, {
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Map<String, dynamic>? body,
  }) async {
    try {
      final request = http.Request(
        method.toUpperCase(),
        Uri.parse(url).replace(queryParameters: query),
      );
      if (headers != null) {
        request.headers.addAll(headers);
      }
      if (body != null) {
        request.body = json.encode(body);
      }
      final response = await request.send();

      final responseData = await _handleResponse(response);

      return responseData.toJson();
    } on SocketException {
      throw NetworkError();
    } catch (e) {
      Logger.error("Network Call Error: $e");
      rethrow;
    }
  }

  static Future<Map<String, dynamic>> _fileRequest(
    String url,
    String method, {
    Map<String, String>? headers,
    Map<String, dynamic>? query,
    Map<String, dynamic>? body,
    Map<String, String>? files,
  }) async {
    try {
      final request = http.MultipartRequest(
        method.toUpperCase(),
        Uri.parse(url).replace(queryParameters: query),
      );

      if (headers != null) {
        request.headers.addAll(headers);
      }

      if (body != null) {
        body.forEach((key, value) {
          request.fields[key] = value.toString();
        });
      }

      if (files != null) {
        for (final entry in files.entries) {
          final file = await http.MultipartFile.fromPath(
            entry.key,
            entry.value,
          );
          request.files.add(file);
        }
      }

      final response = await request.send();

      final responseData = await _handleResponse(response);

      return responseData.toJson();
    } on SocketException {
      throw NetworkError();
    } catch (e) {
      Logger.error("Network Call Error: $e");
      rethrow;
    }
  }

  static Future<GSNetworkResponse> _handleResponse(
    http.StreamedResponse response,
  ) async {
    final statusCode = response.statusCode;
    final stream = await response.stream.bytesToString();

    if (statusCode >= 200 && statusCode < 300) {
      return GSNetworkResponse.fromRawJson(
        stream,
      ).copyWith(success: true, statusCode: statusCode);
    } else {
      return GSNetworkResponse.fromRawJson(
        stream,
      ).copyWith(success: false, statusCode: statusCode);
    }
  }
}
