# FlutterNavigator

FlutterNavigator is a library for dealing with the Navigator API without passing the build context. This package wraps the NavigatorKey and provides a cleaner service for navigating without context in your flutter application.

## Installation

Use the pubspec.yaml file to install the dependency.

```yaml
flutter_navigator: ^0.1.3
```

## Usage

### Adding the Navigator Key

```dart
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigator Key',
      navigatorKey: FlutterNavigator().navigatorKey,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const PageOne(),
    );
  }
}
```

You need to provide the navigator key to your MaterialApp as that is how the service will communicate with the navigator state without the build context.

### Using the FlutterNavigator

```dart
final FlutterNavigator _flutterNavigator = FlutterNavigator();

_flutterNavigator.push(PageTwo.route());
```

The FlutterNavigator is a singleton service so it will always keep the same instance throughout the lifetime of the application. You can call the Navigator API methods through the service (like 'push', 'pop', 'pushAndRemoveUntil', etc)... It's that simple!

### Using the FlutterNavigator Observers

```dart
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Observers',
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
```

As with the navigator key, you can use the route observer provided by the service and this can be accessed throughout the application.

### Creating your own implementation

```dart
class CustomFlutterNavigator implements IFlutterNavigator
```

To create your own implementation, all you need to do is implement the interface IFlutterNavigator and provide all the needed methods and properties.

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

Please make sure to update tests as appropriate.

## License

[MIT](https://choosealicense.com/licenses/mit/)
