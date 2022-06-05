import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

part 'iflutter_navigator.dart';

/// A service that provides access to the [Navigator] API
/// without the need of a build context using a navigator key
class FlutterNavigator implements IFlutterNavigator {
  /// Get's the [FlutterNavigator] instance
  factory FlutterNavigator() => _singleton;

  FlutterNavigator._internal();

  static final FlutterNavigator _singleton = FlutterNavigator._internal();

  @override
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

  @override
  FocusScopeNode get focusScopeNode =>
      navigatorKey.currentState!.focusScopeNode;

  @override
  OverlayState? get overlay => navigatorKey.currentState!.overlay;

  @override
  String? get restorationId => navigatorKey.currentState!.restorationId;

  @override
  bool get userGestureInProgress =>
      navigatorKey.currentState!.userGestureInProgress;

  @override
  ValueNotifier<bool> get userGestureInProgressNotifier =>
      navigatorKey.currentState!.userGestureInProgressNotifier;

  @override
  RestorationBucket? get bucket => navigatorKey.currentState!.bucket;

  @override
  BuildContext get context => navigatorKey.currentState!.context;

  @override
  bool get mounted => navigatorKey.currentState!.mounted;

  @override
  bool get restorePending => navigatorKey.currentState!.restorePending;

  @override
  void activate() => navigatorKey.currentState!.activate();

  @override
  bool canPop() => navigatorKey.currentState!.canPop();

  @override
  Ticker createTicker(void Function(Duration) onTick) =>
      navigatorKey.currentState!.createTicker(onTick);

  @override
  void deactivate() => navigatorKey.currentState!.deactivate();

  @override
  void didChangeDependencies() =>
      navigatorKey.currentState!.didChangeDependencies();

  @override
  void didStartUserGesture() =>
      navigatorKey.currentState!.didStartUserGesture();

  @override
  void didStopUserGesture() => navigatorKey.currentState!.didStopUserGesture();

  @override
  void didToggleBucket(RestorationBucket? oldBucket) =>
      navigatorKey.currentState!.didToggleBucket(oldBucket);

  @override
  void dispose() => navigatorKey.currentState!.dispose();

  @override
  void finalizeRoute(Route<dynamic> route) =>
      navigatorKey.currentState!.finalizeRoute(route);

  @override
  @optionalTypeArgs
  Future<bool> maybePop<T extends Object?>([T? result]) async =>
      navigatorKey.currentState!.maybePop<T>(result);

  @override
  @optionalTypeArgs
  void pop<T extends Object?>([T? result]) =>
      navigatorKey.currentState!.pop(result);

  @override
  @optionalTypeArgs
  Future<T?> popAndPushNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) =>
      navigatorKey.currentState!.popAndPushNamed(
        routeName,
        result: result,
        arguments: arguments,
      );

  @override
  @optionalTypeArgs
  void popUntil(RoutePredicate predicate) =>
      navigatorKey.currentState!.popUntil(predicate);

  @override
  @optionalTypeArgs
  Future<T?> push<T extends Object?>(Route<T> route) {
    return navigatorKey.currentState!.push<T>(route);
  }

  @override
  @optionalTypeArgs
  Future<T?> pushAndRemoveUntil<T extends Object?>(
      Route<T> newRoute, RoutePredicate predicate) {
    return navigatorKey.currentState!
        .pushAndRemoveUntil<T>(newRoute, predicate);
  }

  @override
  @optionalTypeArgs
  Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
    Route<T> newRoute, {
    TO? result,
  }) {
    return navigatorKey.currentState!
        .pushReplacement<T, TO>(newRoute, result: result);
  }

  @override
  @optionalTypeArgs
  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) {
    return navigatorKey.currentState!.pushReplacementNamed<T, TO>(
      routeName,
      result: result,
      arguments: arguments,
    );
  }

  @override
  void removeRoute(Route<dynamic> route) =>
      navigatorKey.currentState!.removeRoute(route);

  @override
  void removeRouteBelow(Route<dynamic> anchorRoute) =>
      navigatorKey.currentState!.removeRouteBelow(anchorRoute);

  @override
  @optionalTypeArgs
  void replace<T extends Object?>(
          {required Route<dynamic> oldRoute, required Route<T> newRoute}) =>
      navigatorKey.currentState!
          .replace<T>(oldRoute: oldRoute, newRoute: newRoute);

  @override
  @optionalTypeArgs
  void replaceRouteBelow<T extends Object?>(
          {required Route<dynamic> anchorRoute, required Route<T> newRoute}) =>
      navigatorKey.currentState!
          .replaceRouteBelow<T>(anchorRoute: anchorRoute, newRoute: newRoute);

  @override
  @optionalTypeArgs
  String restorablePopAndPushNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) =>
      navigatorKey.currentState!.restorablePopAndPushNamed<T, TO>(
        routeName,
        result: result,
        arguments: arguments,
      );

  @override
  @optionalTypeArgs
  String restorablePush<T extends Object?>(
    RestorableRouteBuilder<T> routeBuilder, {
    Object? arguments,
  }) =>
      navigatorKey.currentState!.restorablePush<T>(
        routeBuilder,
        arguments: arguments,
      );

  @override
  @optionalTypeArgs
  String restorablePushAndRemoveUntil<T extends Object?>(
    RestorableRouteBuilder<T> newRouteBuilder,
    RoutePredicate predicate, {
    Object? arguments,
  }) =>
      navigatorKey.currentState!.restorablePushAndRemoveUntil<T>(
        newRouteBuilder,
        predicate,
        arguments: arguments,
      );

  @override
  @optionalTypeArgs
  String restorablePushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) =>
      navigatorKey.currentState!.restorablePushNamed<T>(
        routeName,
        arguments: arguments,
      );

  @override
  @optionalTypeArgs
  String restorablePushNamedAndRemoveUntil<T extends Object?>(
    String routeName,
    RoutePredicate predicate, {
    Object? arguments,
  }) =>
      navigatorKey.currentState!.restorablePushNamedAndRemoveUntil<T>(
        routeName,
        predicate,
        arguments: arguments,
      );

  @override
  @optionalTypeArgs
  String restorablePushReplacement<T extends Object?, TO extends Object?>(
    RestorableRouteBuilder<T> routeBuilder, {
    TO? result,
    Object? arguments,
  }) =>
      navigatorKey.currentState!.restorablePushReplacement<T, TO>(
        routeBuilder,
        result: result,
        arguments: arguments,
      );

  @override
  @optionalTypeArgs
  String restorablePushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  }) =>
      navigatorKey.currentState!.restorablePushReplacementNamed<T, TO>(
        routeName,
        result: result,
        arguments: arguments,
      );

  @override
  @optionalTypeArgs
  String restorableReplace<T extends Object?>({
    required Route<dynamic> oldRoute,
    required RestorableRouteBuilder<T> newRouteBuilder,
    Object? arguments,
  }) =>
      navigatorKey.currentState!.restorableReplace<T>(
        oldRoute: oldRoute,
        newRouteBuilder: newRouteBuilder,
        arguments: arguments,
      );

  @override
  @optionalTypeArgs
  String restorableReplaceRouteBelow<T extends Object?>({
    required Route<dynamic> anchorRoute,
    required RestorableRouteBuilder<T> newRouteBuilder,
    Object? arguments,
  }) =>
      navigatorKey.currentState!.restorableReplaceRouteBelow<T>(
        anchorRoute: anchorRoute,
        newRouteBuilder: newRouteBuilder,
        arguments: arguments,
      );

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) =>
      navigatorKey.currentState!.restoreState(
        oldBucket,
        initialRestore,
      );
}
