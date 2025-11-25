// You have generated a new plugin project without specifying the `--platforms`
// flag. A plugin project with no platform support was generated. To add a
// platform, run `flutter create -t plugin --platforms <platforms> .` under the
// same directory. You can also find a detailed instruction on how to add
// platforms in the `pubspec.yaml` at
// https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'dart:io';

import 'package:console_flutter/managers/console_storage.dart';
import 'package:console_flutter/screens/console_screen.dart';
import 'package:flutter/material.dart';
import 'package:logz/logz.dart';

class Console {
  static void logEnabled(bool enabled) {
    ConsoleStorage.shared.enabled = enabled;
  }

  static void logFileEnabled(String zipPassword, String logFilePrefix, bool printLogs) {
    ConsoleStorage.shared.logZ = LogZ(
      zipPassword: zipPassword,
      logFilePrefix: logFilePrefix,
      printLogs: printLogs,
    );
  }

  static Future<File> zipLog() async {
    return await ConsoleStorage.shared.zipLog();
  }

  static void zipToShareLog() async {
    ConsoleStorage.shared.zipToShareLog();
  }

  static void showConsoleLog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ConsoleScreen(),
      isScrollControlled: true,
      constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height - 40),
    );
  }
}

void log(String message) {
  ConsoleStorage.shared.log(message);
}

void logInfo(String message) {
  ConsoleStorage.shared.logInfo(message);
}

void logError(String message) {
  ConsoleStorage.shared.logError(message);
}
