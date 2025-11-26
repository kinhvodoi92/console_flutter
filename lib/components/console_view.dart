import 'package:console_flutter/managers/console_storage.dart';
import 'package:flutter/material.dart';

import '../console_flutter.dart';

class ConsoleView extends StatefulWidget {
  const ConsoleView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ConsoleViewState();
  }
}

class _ConsoleViewState extends State<ConsoleView> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Console.showConsoleLog(context),
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Center(
          child: ValueListenableBuilder(
            valueListenable: ConsoleStorage.shared.unreadCount,
            builder: (context, value, widget) => Text(
              value.toString(),
              style: const TextStyle(
                  color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
