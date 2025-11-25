import 'package:console_flutter/components/console_wrapper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:console_flutter/console_flutter.dart';

void main() {
  Console.logEnabled(true);
  Console.logFileEnabled("123456", "example", false);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _consoleFlutterPlugin = Console();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ConsoleWrapper(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Plugin example app'),
          ),
          body: Center(
            child: GestureDetector(
              child: Text('Test Console Log'),
              onLongPress: () {
                final zip = Console.zipLog();
                zip.then((file) {
                  if (kDebugMode) {
                    print("Zipped log file path: ${file.path} Size: ${file.lengthSync()} bytes");
                  }
                  Console.zipToShareLog();
                }).catchError((error) {
                  if (kDebugMode) {
                    print("Error zipping log file: $error");
                  }
                });
              },
              onTap: () {
                logInfo("This is a info log message.");
              },
            ),
          ),
        ),
      ),
    );
  }
}
