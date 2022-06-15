// ignore_for_file: comment_references, lines_longer_than_80_chars

part of 'flutter_navigator.dart';

/// An interface for the navigation service
abstract class IFlutterNavigator {
  /// The navigator key used for the app to maintain the stack and state of
  /// the navigation.
  final GlobalKey<NavigatorState>? navigatorKey = GlobalKey<NavigatorState>();

  /// A [Navigator] observer that notifies [RouteAware]s of changes to the
  /// state of their [Route].
  ///
  /// [RouteObserver] informs subscribers whenever a route of type `R` is pushed
  /// on top of their own route of type `R` or popped from it. This is for example
  /// useful to keep track of page transitions, e.g. a `RouteObserver<PageRoute>`
  /// will inform subscribed [RouteAware]s whenever the user navigates away from
  /// the current page route to another page route.
  ///
  /// To be informed about route changes of any type, consider instantiating a
  /// `RouteObserver<Route>`.
  final RouteObserver<PageRoute>? routeObserver = RouteObserver<PageRoute>();

  /// The [FocusScopeNode] for the [FocusScope] that encloses the routes.
  final FocusScopeNode? focusScopeNode =
      FocusScopeNode(debugLabel: 'Navigator Scope');

  /// The overlay this navigator uses for its visual presentation.
  OverlayState? get overlay;

  /// The restoration scope id
  String? get restorationId;

  /// Whether a route is currently being manipulated by the user, e.g.
  /// as during an iOS back gesture.
  ///
  /// See also:
  ///
  ///  * [userGestureInProgressNotifier], which notifies its listeners if
  ///    the value of [userGestureInProgress] changes.
  bool get userGestureInProgress;

  /// Notifies its listeners if the value of [userGestureInProgress] changes.
  final ValueNotifier<bool> userGestureInProgressNotifier =
      ValueNotifier<bool>(false);

  /// The [RestorationBucket] used for the restoration data of the
  /// [RestorableProperty]s registered to this mixin.
  ///
  /// The bucket has been claimed from the surrounding [RestorationScope] using
  /// [restorationId].
  ///
  /// The getter returns null if state restoration is turned off. When state
  /// restoration is turned on or off during the lifetime of this mixin (and
  /// hence the return value of this getter switches between null and non-null)
  /// [didToggleBucket] is called.
  ///
  /// Interacting directly with this bucket is uncommon. However, the bucket may
  /// be injected into the widget tree in the [State]'s `build` method using an
  /// [UnmanagedRestorationScope]. That allows descendants to claim child
  /// buckets from this bucket for their own restoration needs.
  RestorationBucket? get bucket;

  /// The location in the tree where this widget builds.
  ///
  /// The framework associates [State] objects with a [BuildContext] after
  /// creating them with [StatefulWidget.createState] and before calling
  /// [initState]. The association is permanent: the [State] object will never
  /// change its [BuildContext]. However, the [BuildContext] itself can be moved
  /// around the tree.
  ///
  /// After calling [Navigator.dispose], the framework severs the [State] object's
  /// connection with the [BuildContext].
  BuildContext get context;

  /// Whether this [State] object is currently in a tree.
  ///
  /// After creating a [State] object and before calling [initState], the
  /// framework "mounts" the [State] object by associating it with a
  /// [BuildContext]. The [State] object remains mounted until the framework
  /// calls [dispose], after which time the framework will never ask the [State]
  /// object to [build] again.
  ///
  /// It is an error to call [setState] unless [mounted] is true.
  bool get mounted;

  /// Whether [restoreState] will be called at the beginning of the next build
  /// phase.
  ///
  /// Returns true when new restoration data has been provided to the mixin, but
  /// the registered [RestorableProperty]s have not been restored to their new
  /// values (as described by the new restoration data) yet. The properties will
  /// get the values restored when [restoreState] is invoked at the beginning of
  /// the next build cycle.
  ///
  /// While this is true, [bucket] will also still return the old bucket with
  /// the old restoration data. It will update to the new bucket with the new
  /// data just before [restoreState] is invoked.
  bool get restorePending;

  /// Called when this object is reinserted into the tree after having been
  /// removed via [deactivate].
  ///
  /// In most cases, after a [State] object has been deactivated, it is _not_
  /// reinserted into the tree, and its [dispose] method will be called to
  /// signal that it is ready to be garbage collected.
  ///
  /// In some cases, however, after a [State] object has been deactivated, the
  /// framework will reinsert it into another part of the tree (e.g., if the
  /// subtree containing this [State] object is grafted from one location in
  /// the tree to another due to the use of a [GlobalKey]). If that happens,
  /// the framework will call [activate] to give the [State] object a chance to
  /// reacquire any resources that it released in [deactivate]. It will then
  /// also call [build] to give the object a chance to adapt to its new
  /// location in the tree. If the framework does reinsert this subtree, it
  /// will do so before the end of the animation frame in which the subtree was
  /// removed from the tree. For this reason, [State] objects can defer
  /// releasing most resources until the framework calls their [dispose] method.
  ///
  /// The framework does not call this method the first time a [State] object
  /// is inserted into the tree. Instead, the framework calls [initState] in
  /// that situation.
  ///
  /// Implementations of this method should start with a call to the inherited
  /// method, as in `super.activate()`.
  ///
  /// See also:
  ///
  ///  * [Element.activate], the corresponding method when an element
  ///    transitions from the "inactive" to the "active" lifecycle state.
  void activate();

  /// Whether the navigator can be popped.
  ///
  /// {@macro flutter.widgets.navigator.canPop}
  ///
  /// See also:
  ///
  ///  * [Route.isFirst], which returns true for routes for which [canPop]
  ///    returns false.
  bool canPop();

  /// Creates a ticker with the given callback.
  ///
  /// The kind of ticker provided depends on the kind of ticker provider.
  Ticker createTicker(TickerCallback onTick);

  /// Called when this object is removed from the tree.
  ///
  /// The framework calls this method whenever it removes this [State] object
  /// from the tree. In some cases, the framework will reinsert the [State]
  /// object into another part of the tree (e.g., if the subtree containing this
  /// [State] object is grafted from one location in the tree to another due to
  /// the use of a [GlobalKey]). If that happens, the framework will call
  /// [activate] to give the [State] object a chance to reacquire any resources
  /// that it released in [deactivate]. It will then also call [build] to give
  /// the [State] object a chance to adapt to its new location in the tree. If
  /// the framework does reinsert this subtree, it will do so before the end of
  /// the animation frame in which the subtree was removed from the tree. For
  /// this reason, [State] objects can defer releasing most resources until the
  /// framework calls their [dispose] method.
  ///
  /// Subclasses should override this method to clean up any links between
  /// this object and other elements in the tree (e.g. if you have provided an
  /// ancestor with a pointer to a descendant's [RenderObject]).
  ///
  /// Implementations of this method should end with a call to the inherited
  /// method, as in `super.deactivate()`.
  ///
  /// See also:
  ///
  ///  * [dispose], which is called after [deactivate] if the widget is removed
  ///    from the tree permanently.
  void deactivate();

  /// Called when a dependency of this [State] object changes.
  ///
  /// For example, if the previous call to [build] referenced an
  /// [InheritedWidget] that later changed, the framework would call this
  /// method to notify this object about the change.
  ///
  /// This method is also called immediately after [initState]. It is safe to
  /// call [BuildContext.dependOnInheritedWidgetOfExactType] from this method.
  ///
  /// Subclasses rarely override this method because the framework always
  /// calls [build] after a dependency changes. Some subclasses do override
  /// this method because they need to do some expensive work (e.g., network
  /// fetches) when their dependencies change, and that work would be too
  /// expensive to do for every build.
  void didChangeDependencies();

  /// The navigator is being controlled by a user gesture.
  ///
  /// For example, called when the user beings an iOS back gesture.
  ///
  /// When the gesture finishes, call [didStopUserGesture].
  void didStartUserGesture();

  /// A user gesture completed.
  ///
  /// Notifies the navigator that a gesture regarding which the navigator was
  /// previously notified with [didStartUserGesture] has completed.
  void didStopUserGesture();

  /// Called when [bucket] switches between null and non-null values.
  ///
  /// [State] objects that wish to directly interact with the bucket may
  /// override this method to store additional values in the bucket when one
  /// becomes available or to save values stored in a bucket elsewhere when the
  /// bucket goes away. This is uncommon and storing those values in
  /// [RestorableProperty]s should be considered instead.
  ///
  /// The `oldBucket` is provided to the method when the [bucket] getter changes
  /// from non-null to null. The `oldBucket` argument is null when the [bucket]
  /// changes from null to non-null.
  ///
  /// See also:
  ///
  ///  * [restoreState], which is called when the [bucket] changes from one
  ///    non-null value to another non-null value.
  void didToggleBucket(RestorationBucket? oldBucket);

  /// Called when this object is removed from the tree permanently.
  ///
  /// The framework calls this method when this [State] object will never
  /// build again. After the framework calls [dispose], the [State] object is
  /// considered unmounted and the [mounted] property is false. It is an error
  /// to call [setState] at this point. This stage of the lifecycle is terminal:
  /// there is no way to remount a [State] object that has been disposed.
  ///
  /// Subclasses should override this method to release any resources retained
  /// by this object (e.g., stop any active animations).
  ///
  /// {@macro flutter.widgets.State.initState}
  ///
  /// Implementations of this method should end with a call to the inherited
  /// method, as in `super.dispose()`.
  ///
  /// See also:
  ///
  ///  * [deactivate], which is called prior to [dispose].
  @protected
  void dispose();

  /// Complete the lifecycle for a route that has been popped off the navigator.
  ///
  /// When the navigator pops a route, the navigator retains a reference to the
  /// route in order to call [Route.dispose] if the navigator itself is removed
  /// from the tree. When the route is finished with any exit animation, the
  /// route should call this function to complete its lifecycle (e.g., to
  /// receive a call to [Route.dispose]).
  ///
  /// The given `route` must have already received a call to [Route.didPop].
  /// This function may be called directly from [Route.didPop] if [Route.didPop]
  /// will return true.
  void finalizeRoute(Route<dynamic> route);

  /// Consults the current route's [Route.willPop] method, and acts accordingly,
  /// potentially popping the route as a result; returns whether the pop request
  /// should be considered handled.
  ///
  /// {@macro flutter.widgets.navigator.maybePop}
  ///
  /// See also:
  ///
  ///  * [Form], which provides an `onWillPop` callback that enables the form
  ///    to veto a [pop] initiated by the app's back button.
  ///  * [ModalRoute], which provides a `scopedWillPopCallback` that can be used
  ///    to define the route's `willPop` method.
  @optionalTypeArgs
  Future<bool> maybePop<T extends Object?>([T? result]);

  /// Pop the top-most route off the navigator.
  ///
  /// {@macro flutter.widgets.navigator.pop}
  ///
  /// {@tool snippet}
  ///
  /// Typical usage for closing a route is as follows:
  ///
  /// ```dart
  /// void _handleClose() {
  ///   navigator.pop();
  /// }
  /// ```
  /// {@end-tool}
  /// {@tool snippet}
  ///
  /// A dialog box might be closed with a result:
  ///
  /// ```dart
  /// void _handleAccept() {
  ///   navigator.pop(true); // dialog returns true
  /// }
  /// ```
  /// {@end-tool}
  @optionalTypeArgs
  void pop<T extends Object?>([T? result]);

  /// Pop the current route off the navigator and push a named route in its
  /// place.
  ///
  /// {@macro flutter.widgets.navigator.popAndPushNamed}
  ///
  /// {@macro flutter.widgets.Navigator.pushNamed}
  ///
  /// {@tool snippet}
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// void _begin() {
  ///   navigator.popAndPushNamed('/nyc/1776');
  /// }
  /// ```
  /// {@end-tool}
  ///
  /// See also:
  ///
  ///  * [restorablePopAndPushNamed], which pushes a new route that can be
  ///    restored during state restoration.
  @optionalTypeArgs
  Future<T?> popAndPushNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  });

  /// Calls [pop] repeatedly until the predicate returns true.
  ///
  /// {@macro flutter.widgets.navigator.popUntil}
  ///
  /// {@tool snippet}
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// void _doLogout() {
  ///   navigator.popUntil(ModalRoute.withName('/login'));
  /// }
  /// ```
  /// {@end-tool}
  void popUntil(RoutePredicate predicate);

  /// Push the given route onto the navigator that most tightly encloses the
  /// given context.
  ///
  /// {@template flutter.widgets.navigator.push}
  /// The new route and the previous route (if any) are notified (see
  /// [Route.didPush] and [Route.didChangeNext]).
  ///
  /// Ongoing gestures within the current route are canceled when a new route is
  /// pushed.
  ///
  /// Returns a [Future] that completes to the `result` value passed to [pop]
  /// when the pushed route is popped off the navigator.
  ///
  /// The `T` type argument is the type of the return value of the route.
  /// {@endtemplate}
  ///
  /// {@tool snippet}
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// void _openMyPage() {
  ///   NavigationService().push<void>(
  ///     MaterialPageRoute<void>(
  ///       builder: (BuildContext context) => const MyPage(),
  ///     ),
  ///   );
  /// }
  /// ```
  /// {@end-tool}
  ///
  /// See also:
  ///
  ///  * [restorablePush], which pushes a route that can be restored during
  ///    state restoration.
  @optionalTypeArgs
  Future<T?> push<T extends Object?>(Route<T> route);

  /// Push a named route onto the navigator.
  ///
  /// {@macro flutter.widgets.navigator.pushNamed}
  ///
  /// {@macro flutter.widgets.Navigator.pushNamed}
  ///
  /// {@tool snippet}
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// void _aaronBurrSir() {
  ///   navigator.pushNamed('/nyc/1776');
  /// }
  /// ```
  /// {@end-tool}
  ///
  /// See also:
  ///
  ///  * [restorablePushNamed], which pushes a route that can be restored
  ///    during state restoration.
  @optionalTypeArgs
  Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  });

  /// Push the given route onto the navigator, and then remove all the previous
  /// routes until the `predicate` returns true.
  ///
  /// {@macro flutter.widgets.navigator.pushAndRemoveUntil}
  ///
  /// {@tool snippet}
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// void _resetAndOpenPage() {
  ///   navigator.pushAndRemoveUntil<void>(
  ///     MaterialPageRoute<void>(builder: (BuildContext context) => const MyHomePage()),
  ///     ModalRoute.withName('/'),
  ///   );
  /// }
  /// ```
  /// {@end-tool}
  ///
  ///
  /// See also:
  ///
  ///  * [restorablePushAndRemoveUntil], which pushes a route that can be
  ///    restored during state restoration.
  @optionalTypeArgs
  Future<T?> pushAndRemoveUntil<T extends Object?>(
    Route<T> newRoute,
    RoutePredicate predicate,
  );

  /// Replace the current route of the navigator by pushing the given route and
  /// then disposing the previous route once the new route has finished
  /// animating in.
  ///
  /// {@macro flutter.widgets.navigator.pushReplacement}
  ///
  /// {@tool snippet}
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// void _doOpenPage() {
  ///   NavigationService().pushReplacement<void, void>(
  ///     MaterialPageRoute<void>(
  ///       builder: (BuildContext context) => const MyHomePage(),
  ///     ),
  ///   );
  /// }
  /// ```
  /// {@end-tool}
  ///
  /// See also:
  ///
  ///  * [restorablePushReplacement], which pushes a replacement route that can
  ///    be restored during state restoration.
  @optionalTypeArgs
  Future<T?> pushReplacement<T extends Object?, TO extends Object?>(
    Route<T> newRoute, {
    TO? result,
  });

  /// Replace the current route of the navigator by pushing the route named
  /// [routeName] and then disposing the previous route once the new route has
  /// finished animating in.
  ///
  /// {@macro flutter.widgets.navigator.pushReplacementNamed}
  ///
  /// {@macro flutter.widgets.Navigator.pushNamed}
  ///
  /// {@tool snippet}
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// void _startBike() {
  ///   navigator.pushReplacementNamed('/jouett/1781');
  /// }
  /// ```
  /// {@end-tool}
  ///
  /// See also:
  ///
  ///  * [restorablePushReplacementNamed], which pushes a replacement route that
  ///  can be restored during state restoration.
  @optionalTypeArgs
  Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  });

  /// Immediately remove `route` from the navigator, and [Route.dispose] it.
  ///
  /// {@macro flutter.widgets.navigator.removeRoute}
  void removeRoute(Route<dynamic> route);

  /// Immediately remove a route from the navigator, and [Route.dispose] it. The
  /// route to be removed is the one below the given `anchorRoute`.
  ///
  /// {@macro flutter.widgets.navigator.removeRouteBelow}
  void removeRouteBelow(Route<dynamic> anchorRoute);

  /// Replaces a route on the navigator with a new route.
  ///
  /// {@macro flutter.widgets.navigator.replace}
  ///
  /// See also:
  ///
  ///  * [replaceRouteBelow], which is the same but identifies the route to be
  ///    removed by reference to the route above it, rather than directly.
  ///  * [restorableReplace], which adds a replacement route that can be
  ///    restored during state restoration.
  @optionalTypeArgs
  void replace<T extends Object?>({
    required Route<dynamic> oldRoute,
    required Route<T> newRoute,
  });

  /// Replaces a route on the navigator with a new route. The route to be
  /// replaced is the one below the given `anchorRoute`.
  ///
  /// {@macro flutter.widgets.navigator.replaceRouteBelow}
  ///
  /// See also:
  ///
  ///  * [replace], which is the same but identifies the route to be removed
  ///    directly.
  ///  * [restorableReplaceRouteBelow], which adds a replacement route that can
  ///    be restored during state restoration.
  @optionalTypeArgs
  void replaceRouteBelow<T extends Object?>({
    required Route<dynamic> anchorRoute,
    required Route<T> newRoute,
  });

  /// Pop the current route off the navigator and push a named route in its
  /// place.
  ///
  /// {@macro flutter.widgets.navigator.restorablePopAndPushNamed}
  ///
  /// {@macro flutter.widgets.navigator.popAndPushNamed}
  ///
  /// {@macro flutter.widgets.Navigator.restorablePushNamed.arguments}
  ///
  /// {@macro flutter.widgets.Navigator.restorablePushNamed.returnValue}
  ///
  /// {@tool snippet}
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// void _end() {
  ///   navigator.restorablePopAndPushNamed('/nyc/1776');
  /// }
  /// ```
  /// {@end-tool}
  @optionalTypeArgs
  String restorablePopAndPushNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  });

  /// Push a new route onto the navigator.
  ///
  /// {@macro flutter.widgets.navigator.restorablePush}
  ///
  /// {@macro flutter.widgets.navigator.push}
  ///
  /// {@macro flutter.widgets.Navigator.restorablePush}
  ///
  /// {@macro flutter.widgets.Navigator.restorablePushNamed.returnValue}
  ///
  /// {@tool dartpad}
  /// Typical usage is as follows:
  ///
  /// ** See code in examples/api/lib/widgets/navigator/navigator_state.restorable_push.0.dart **
  /// {@end-tool}
  @optionalTypeArgs
  String restorablePush<T extends Object?>(
    RestorableRouteBuilder<T> routeBuilder, {
    Object? arguments,
  });

  /// Push a new route onto the navigator, and then remove all the previous
  /// routes until the `predicate` returns true.
  ///
  /// {@macro flutter.widgets.navigator.restorablePushAndRemoveUntil}
  ///
  /// {@macro flutter.widgets.navigator.pushAndRemoveUntil}
  ///
  /// {@macro flutter.widgets.Navigator.restorablePush}
  ///
  /// {@macro flutter.widgets.Navigator.restorablePushNamed.returnValue}
  ///
  /// {@tool dartpad}
  /// Typical usage is as follows:
  ///
  /// ** See code in examples/api/lib/widgets/navigator/navigator_state.restorable_push_and_remove_until.0.dart **
  /// {@end-tool}
  @optionalTypeArgs
  String restorablePushAndRemoveUntil<T extends Object?>(
    RestorableRouteBuilder<T> newRouteBuilder,
    RoutePredicate predicate, {
    Object? arguments,
  });

  /// Push a named route onto the navigator.
  ///
  /// {@macro flutter.widgets.navigator.restorablePushNamed}
  ///
  /// {@macro flutter.widgets.navigator.pushNamed}
  ///
  /// {@macro flutter.widgets.Navigator.restorablePushNamed.arguments}
  ///
  /// {@macro flutter.widgets.Navigator.restorablePushNamed.returnValue}
  ///
  /// {@tool snippet}
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// void _openDetails() {
  ///   navigator.restorablePushNamed('/nyc/1776');
  /// }
  /// ```
  /// {@end-tool}
  @optionalTypeArgs
  String restorablePushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  });

  /// Push the route with the given name onto the navigator, and then remove all
  /// the previous routes until the `predicate` returns true.
  ///
  /// {@macro flutter.widgets.navigator.restorablePushNamedAndRemoveUntil}
  ///
  /// {@macro flutter.widgets.navigator.pushNamedAndRemoveUntil}
  ///
  /// {@macro flutter.widgets.Navigator.restorablePushNamed.arguments}
  ///
  /// {@macro flutter.widgets.Navigator.restorablePushNamed.returnValue}
  ///
  /// {@tool snippet}
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// void _openCalendar() {
  ///   navigator.restorablePushNamedAndRemoveUntil('/calendar', ModalRoute.withName('/'));
  /// }
  /// ```
  /// {@end-tool}
  @optionalTypeArgs
  String restorablePushNamedAndRemoveUntil<T extends Object?>(
    String newRouteName,
    RoutePredicate predicate, {
    Object? arguments,
  });

  /// Replace the current route of the navigator by pushing a new route and
  /// then disposing the previous route once the new route has finished
  /// animating in.
  ///
  /// {@macro flutter.widgets.navigator.restorablePushReplacement}
  ///
  /// {@macro flutter.widgets.navigator.pushReplacement}
  ///
  /// {@macro flutter.widgets.Navigator.restorablePush}
  ///
  /// {@macro flutter.widgets.Navigator.restorablePushNamed.returnValue}
  @optionalTypeArgs
  String restorablePushReplacement<T extends Object?, TO extends Object?>(
    RestorableRouteBuilder<T> routeBuilder, {
    TO? result,
    Object? arguments,
  });

  /// Replace the current route of the navigator by pushing the route named
  /// [routeName] and then disposing the previous route once the new route has
  /// finished animating in.
  ///
  /// {@macro flutter.widgets.navigator.restorablePushReplacementNamed}
  ///
  /// {@macro flutter.widgets.navigator.pushReplacementNamed}
  ///
  /// {@macro flutter.widgets.Navigator.restorablePushNamed.arguments}
  ///
  /// {@macro flutter.widgets.Navigator.restorablePushNamed.returnValue}
  ///
  /// {@tool snippet}
  ///
  /// Typical usage is as follows:
  ///
  /// ```dart
  /// void _startCar() {
  ///   navigator.restorablePushReplacementNamed('/jouett/1781');
  /// }
  /// ```
  /// {@end-tool}
  @optionalTypeArgs
  String restorablePushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    TO? result,
    Object? arguments,
  });

  /// Replaces a route on the navigator with a new route.
  ///
  /// {@macro flutter.widgets.navigator.restorableReplace}
  ///
  /// {@macro flutter.widgets.navigator.replace}
  ///
  /// {@macro flutter.widgets.Navigator.restorablePush}
  ///
  /// {@macro flutter.widgets.Navigator.restorablePushNamed.returnValue}
  @optionalTypeArgs
  String restorableReplace<T extends Object?>({
    required Route<dynamic> oldRoute,
    required RestorableRouteBuilder<T> newRouteBuilder,
    Object? arguments,
  });

  /// Replaces a route on the navigator with a new route. The route to be
  /// replaced is the one below the given `anchorRoute`.
  ///
  /// {@macro flutter.widgets.navigator.restorableReplaceRouteBelow}
  ///
  /// {@macro flutter.widgets.navigator.replaceRouteBelow}
  ///
  /// {@macro flutter.widgets.Navigator.restorablePush}
  ///
  /// {@macro flutter.widgets.Navigator.restorablePushNamed.returnValue}
  @optionalTypeArgs
  String restorableReplaceRouteBelow<T extends Object?>({
    required Route<dynamic> anchorRoute,
    required RestorableRouteBuilder<T> newRouteBuilder,
    Object? arguments,
  });

  /// Called to initialize or restore the [RestorableProperty]s used by the
  /// [State] object.
  ///
  /// This method is always invoked at least once right after [State.initState]
  /// to register the [RestorableProperty]s with the mixin even when state
  /// restoration is turned off or no restoration data is available for this
  /// [State] object.
  ///
  /// Typically, [registerForRestoration] is called from this method to register
  /// all [RestorableProperty]s used by the [State] object with the mixin. The
  /// registration will either restore the property's value to the value
  /// described by the restoration data, if available, or, if no restoration
  /// data is available - initialize it to a property-specific default value.
  ///
  /// The method is called again whenever new restoration data (in the form of a
  /// new [bucket]) has been provided to the mixin. When that happens, the
  /// [State] object must re-register all previously registered properties,
  /// which will restore their values to the value described by the new
  /// restoration data.
  ///
  /// Since the method may change the value of the registered properties when
  /// new restoration state is provided, all initialization logic that depends
  /// on a specific value of a [RestorableProperty] should be included in this
  /// method. That way, that logic re-executes when the [RestorableProperty]s
  /// have their values restored from newly provided restoration data.
  ///
  /// The first time the method is invoked, the provided `oldBucket` argument is
  /// always null. In subsequent calls triggered by new restoration data in the
  /// form of a new bucket, the argument given is the previous value of
  /// [bucket].
  @mustCallSuper
  @protected
  void restoreState(RestorationBucket? oldBucket, bool initialRestore);
}
