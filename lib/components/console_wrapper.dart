import 'package:console_flutter/components/console_view.dart';
import 'package:console_flutter/managers/console_storage.dart';
import 'package:flutter/material.dart';

/// A wrapper widget that adds a draggable console view to the application.
class ConsoleWrapper extends StatefulWidget {
  const ConsoleWrapper({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  State<StatefulWidget> createState() {
    return _ConsoleWrapperState();
  }
}

class _ConsoleWrapperState extends State<ConsoleWrapper> {
  late Offset _offset =
      Offset(MediaQuery.of(context).size.width - 20 - 50, 100);
  bool _dragging = false;
  double _opacity = 0.2;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Positioned.fill(child: widget.child),
          if (ConsoleStorage.shared.enabled)
            AnimatedPositioned(
              duration: Duration(milliseconds: _dragging ? 0 : 300),
              top: _offset.dy,
              left: _offset.dx,
              child: Draggable(
                feedback: const ColoredBox(color: Colors.yellow),
                onDragUpdate: (info) {
                  setState(() {
                    _dragging = true;
                    _opacity = 1;
                    _offset = Offset(info.globalPosition.dx - 25,
                        info.globalPosition.dy - 25);
                  });
                },
                onDragEnd: (info) {
                  final pos = info.offset;
                  final screenSize = MediaQuery.of(context).size;

                  double x = pos.dx >= screenSize.width / 2
                      ? screenSize.width - 20 - 50
                      : 20;
                  setState(() {
                    _dragging = false;
                    _opacity = 0.2;
                    _offset = Offset(x, pos.dy);
                  });
                },
                child: Opacity(
                  opacity: _opacity,
                  child: ConsoleView(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
