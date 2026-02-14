import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:g_sync/src/core/extensions/extensions.dart';

class Logger {
  const Logger._();

  static const String _name = "G_SYNC";

  static void info(String message) => dev.log(
    "[${TimeOfDay.now().toTimeString12}] -> $message",
    name: _name,
    time: DateTime.now(),
    level: 800, // Info level
  );

  static void warning(String message) => dev.log(
    "[${TimeOfDay.now().toTimeString12}] -> $message",
    name: _name,
    time: DateTime.now(),
    level: 900, // Warning level
  );

  static void error(String message, {Object? error, StackTrace? stackTrace}) =>
      dev.log(
        "[${TimeOfDay.now().toTimeString12}] -> $message",
        name: _name,
        time: DateTime.now(),
        stackTrace: stackTrace,
        error: error,
        level: 1000, // Error level
      );

  static void plain(String message, [bool allCap = true]) {
    final mainMessage = allCap ? message.toUpperCase() : message;
    final holeMessage =
        "[${TimeOfDay.now().toTimeString12}] -> \n\t$mainMessage]";

    dev.log(holeMessage, name: _name, time: DateTime.now());
  }
}
