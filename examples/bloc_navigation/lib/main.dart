import 'package:bloc_navigation/page_one/view/page_one.dart';
import 'package:flutter/material.dart';
import 'package:flutter_navigator/flutter_navigator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BLoC Navigation',
      navigatorKey: FlutterNavigator().navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: [
        FlutterNavigator().routeObserver,
      ],
      home: const PageOne(),
    );
  }
}
