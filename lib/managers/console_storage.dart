import 'package:flutter/foundation.dart';

enum LogItemType { info, error, verbose }

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

class ConsoleStorage {
  static final shared = ConsoleStorage();

  bool enabled = false;
  final ValueNotifier<List<LogItem>> _logs = ValueNotifier([]);
  final ValueNotifier<int> unreadCount = ValueNotifier(0);

  ValueNotifier<List<LogItem>> get logsNotifier {
    return _logs;
  }

  List<LogItem> get logs {
    return _logs.value;
  }

  void clear() {
    _logs.value = [];
  }

  void resetUnreadCount() {
    unreadCount.value = 0;
  }

  void _addLog(LogItem item) {
    if (kDebugMode) {
      print(item.content);
    }
    if (!enabled) return;
    _logs.value += [item];
    unreadCount.value++;
  }

  void logInfo(String message) {
    _addLog(LogItem(
      content: message,
      type: LogItemType.info,
      time: DateTime.now(),
    ));
  }

  void logError(String message) {
    _addLog(LogItem(
      content: message,
      type: LogItemType.error,
      time: DateTime.now(),
    ));
  }

  void log(String message) {
    _addLog(LogItem(
      content: message,
      type: LogItemType.verbose,
      time: DateTime.now(),
    ));
  }
}
