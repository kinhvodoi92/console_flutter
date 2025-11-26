import 'dart:io';

import 'package:flutter/foundation.dart';

/// An enumeration representing the type of log item.
enum LogItemType { info, error, verbose }

/// A class representing a log item with content, type, and timestamp.
class LogItem {
  LogItem({
    required this.content,
    this.type = LogItemType.verbose,
    required this.time,
  });

  final String content;
  final LogItemType type;
  final DateTime time;
}

/// A singleton class that manages console storage and logging.
class ConsoleStorage {
  /// The shared singleton instance of ConsoleStorage.
  static final shared = ConsoleStorage();

  /// Indicates whether logging is enabled.
  bool enabled = false;
  final ValueNotifier<List<LogItem>> _logs = ValueNotifier([]);
  final ValueNotifier<int> unreadCount = ValueNotifier(0);
  late final logZ;

  ValueNotifier<List<LogItem>> get logsNotifier {
    return _logs;
  }

  List<LogItem> get logs {
    return _logs.value;
  }

  /// Clears all stored logs.
  void clear() {
    _logs.value = [];
  }

  /// Resets the unread log count to zero.
  void resetUnreadCount() {
    unreadCount.value = 0;
  }

  /// Initializes file logging with the given parameters.
  Future<File> zipLog() async {
    if (logZ == null) {
      throw Exception("LogZ is not initialized.");
    }
    return await logZ.zipLog();
  }

  /// Zips the log file and initiates sharing.
  void zipToShareLog() {
    if (logZ == null) {
      throw Exception("LogZ is not initialized.");
    }
    logZ.zipToShareLog();
  }

  void _addLog(LogItem item) {
    if (logZ != null) {
      logZ.logToFile(
        '${item.time.toIso8601String()} [${item.type.name}]:\n${item.content}',
      );
    }

    if (kDebugMode) {
      print(item.content);
    }
    if (!enabled) return;
    _logs.value += [item];
    unreadCount.value++;
  }

  /// Logs an informational message.
  void logInfo(String message) {
    _addLog(LogItem(
      content: message,
      type: LogItemType.info,
      time: DateTime.now(),
    ));
  }

  /// Logs an error message.
  void logError(String message) {
    _addLog(LogItem(
      content: message,
      type: LogItemType.error,
      time: DateTime.now(),
    ));
  }

  /// Logs a verbose message.
  void log(String message) {
    _addLog(LogItem(
      content: message,
      type: LogItemType.verbose,
      time: DateTime.now(),
    ));
  }
}
