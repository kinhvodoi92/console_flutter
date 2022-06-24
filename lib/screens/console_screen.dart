import 'package:console_flutter/managers/console_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../managers/console_storage.dart';

class ConsoleScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ConsoleScreenState();
  }
}

class _ConsoleScreenState extends State<ConsoleScreen> {
  double _fontSize = 14;

  double get _padding {
    return _fontSize - 2;
  }

  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      ConsoleStorage.shared.resetUnreadCount();
    });
  }

  @override
  void dispose() {
    ConsoleStorage.shared.resetUnreadCount();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Console Logs"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.blue,
        leading: IconButton(
          onPressed: _dismiss,
          icon: const Icon(Icons.close),
        ),
        actions: [
          IconButton(
              onPressed: _decreaseFont, icon: const Icon(Icons.text_decrease)),
          IconButton(
              onPressed: _increaseFont, icon: const Icon(Icons.text_increase)),
          IconButton(
              onPressed: _scrollToBottom,
              icon: const Icon(Icons.keyboard_double_arrow_down)),
          IconButton(
              onPressed: _scrollToTop,
              icon: const Icon(Icons.keyboard_double_arrow_up)),
          TextButton(
            onPressed: _clearLogs,
            child: const Text(
              ConsoleText.clear,
              style: TextStyle(
                  fontSize: 16, fontWeight: FontWeight.w500, color: Colors.red),
            ),
          ),
        ],
      ),
      body: ValueListenableBuilder<List<LogItem>>(
          valueListenable: ConsoleStorage.shared.logsNotifier,
          builder: (context, value, widget) {
            final items = value.reversed.toList();
            return items.isEmpty
                ? Center(
                    child: Text(
                      ConsoleText.noLog,
                      style: TextStyle(
                          fontSize: _fontSize, fontWeight: FontWeight.w500),
                    ),
                  )
                : Scrollbar(
                    child: ListView.separated(
                      controller: _controller,
                      reverse: true,
                      padding: EdgeInsets.all(_padding),
                      itemBuilder: (context, index) =>
                          _itemWidget(items[index]),
                      separatorBuilder: (context, index) => Container(
                        height: 1,
                        color: Colors.orange,
                        margin: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      itemCount: items.length,
                    ),
                  );
          }),
    );
  }

  Widget _itemWidget(LogItem item) {
    final date = item.time;
    final time =
        "${date.hour.toString().padLeft(2, "0")}:${date.minute.toString().padLeft(2, "0")}:${date.second.toString().padLeft(2, "0")}";
    switch (item.type) {
      case LogItemType.info:
        return InkWell(
          child: Text(
            "$time | [Info]: ${item.content}",
            style: TextStyle(color: Colors.blue, fontSize: _fontSize),
          ),
          onLongPress: () {
            Clipboard.setData(ClipboardData(text: item.content)).then(
              (value) => ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Copied"))),
            );
          },
        );
      case LogItemType.error:
        return InkWell(
          child: Text(
            "$time | [Error]: ${item.content}",
            style: TextStyle(color: Colors.red, fontSize: _fontSize),
          ),
          onLongPress: () {
            Clipboard.setData(ClipboardData(text: item.content)).then(
              (value) => ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Copied"))),
            );
          },
        );
      case LogItemType.verbose:
        return InkWell(
          child: Text(
            "$time | ${item.content}",
            style: TextStyle(color: Colors.black, fontSize: _fontSize),
          ),
          onLongPress: () {
            Clipboard.setData(ClipboardData(text: item.content)).then(
              (value) => ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Copied"))),
            );
          },
        );
    }
  }

  void _dismiss() {
    Navigator.of(context).pop();
  }

  void _clearLogs() {
    ConsoleStorage.shared.clear();
  }

  void _increaseFont() {
    if (_fontSize >= 30) return;
    setState(() {
      _fontSize += 2;
    });
  }

  void _decreaseFont() {
    if (_fontSize <= 4) return;
    setState(() {
      _fontSize -= 2;
    });
  }

  void _scrollToTop() {
    if (ConsoleStorage.shared.logs.isEmpty) return;
    _controller.animateTo(
      _controller.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToBottom() {
    if (ConsoleStorage.shared.logs.isEmpty) return;
    _controller.animateTo(
      _controller.position.minScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }
}
