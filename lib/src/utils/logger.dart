import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';

/// log the message in the terminal
///
/// [message] is required, you can pass any message
void log(
  String message, {
  DateTime? time,
  int? sequenceNumber,
  int level = 0,
  String name = '',
  Object? error,
  Zone? zone,
  StackTrace? stackTrace,
}) =>
    SecretLogger().log(
      message,
      name: name,
      error: error,
      level: level,
      sequenceNumber: sequenceNumber,
      stackTrace: stackTrace,
      time: time,
      zone: zone,
    );

/// log error message in the terminal
///
/// [message] is required, you can pass any message
void logError(
  String message, {
  DateTime? time,
  int? sequenceNumber,
  int level = 0,
  String name = 'Logger',
  Object? error,
  Zone? zone,
  StackTrace? stackTrace,
}) =>
    SecretLogger().logError(
      message,
      name: name,
      error: error,
      sequenceNumber: sequenceNumber,
      stackTrace: stackTrace,
      time: time,
      zone: zone,
    );

/// Logger class
///
/// This class is used to log the message in the terminal
class SecretLogger {
  factory SecretLogger() => _instance;

  SecretLogger._();

  static final SecretLogger _instance = SecretLogger._();

  /// log the message in the terminal
  void log(
    String message, {
    DateTime? time,
    int? sequenceNumber,
    int level = 0,
    String name = 'Logger',
    Object? error,
    Zone? zone,
    StackTrace? stackTrace,
  }) {
    final msg = '$name: $message ${error ?? ''}';

    if (!Debug().isRelease) {
      debugPrint(msg);
    }
  }

  /// log error message in the terminal
  void logError(
    String message, {
    DateTime? time,
    int? sequenceNumber,
    String name = 'Logger',
    Object? error,
    Zone? zone,
    StackTrace? stackTrace,
  }) {
    // ignore: avoid_print
    print('LinkedInLogin: $message ${error ?? ''}');
    stderr
      ..writeln('$message ${error ?? ''}')
      ..flush();
  }
}

/// Debug class
///
/// This class is used to check if the app is in debug mode or not
class Debug {
  bool get isRelease => bool.fromEnvironment('dart.vm.product');
}
