import 'package:bloc/bloc.dart';
import 'package:bloc_navigation/page_two/view/page_two.dart';
import 'package:meta/meta.dart';
import 'package:flutter_navigator/flutter_navigator.dart';

part 'page_one_event.dart';
part 'page_one_state.dart';

class PageOneBloc extends Bloc<PageOneEvent, PageOneState> {
  PageOneBloc(this._flutterNavigator) : super(PageoneInitial()) {
    on<NavigateToPageTwoEvent>(_onNavigateToPageTwoEvent);
  }

  final FlutterNavigator _flutterNavigator;

  void _onNavigateToPageTwoEvent(
      NavigateToPageTwoEvent event, Emitter<PageOneState> emit) {
    _flutterNavigator.push(PageTwo.route());
  }
}
