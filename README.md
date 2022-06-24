# console_flutter

A simple Flutter package project to store, view, and manage app console log, API logs.

Base log type:
- `verbose` (<span style="color:black">Default, with black color text</span>)
- `info` (<span style="color:blue">Blue color text</span>)
- `error` (<span style="color:red">Red color text</span>)

<p float="left">
  <img src="https://raw.githubusercontent.com/kinhvodoi92/console_flutter/images/1.PNG" width="24%" />
  <img src="https://raw.githubusercontent.com/kinhvodoi92/console_flutter/images/2.PNG" width="24%" /> 
  <img src="https://raw.githubusercontent.com/kinhvodoi92/console_flutter/images/3.PNG" width="24%" />
  <img src="https://raw.githubusercontent.com/kinhvodoi92/console_flutter/images/4.PNG" width="24%" />
</p>

## <span style="color:orange">Installation</span>

In the `dependencies:` section of your `pubspec.yaml`, add the following line:

```yaml
dependencies:
  console_flutter: <latest_version>
```

## <span style="color:orange">Usage</span>

In main function
```dart
import 'package:console_flutter/console_flutter.dart';

void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    Console.logEnabled(kDebugMode); // false will ignore Console view
    runApp(MyApp());
}
```
- ### Method 1: WrapperWidget


In your app
```dart
import 'package:console_flutter/console_flutter.dart';

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
        ...
        body: ConsoleWrapper(
            child: MyHomePage(),
        ),
    );
  }
}
```
- ### Method 2: Custom Navigate
Custom your view and action to open Logs Screen
```dart
import 'package:console_flutter/console_flutter.dart';

Console.showConsoleLog(context);
```