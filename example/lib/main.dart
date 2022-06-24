import 'package:console_flutter/components/console_wrapper.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:console_flutter/console_flutter.dart';

void main() {
  Console.logEnabled(true);
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
            child: Text('ConsoleFlutter'),
          ),
        ),
      ),
    );
  }
}
