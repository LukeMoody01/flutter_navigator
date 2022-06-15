import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'page_one_event.dart';
part 'page_one_state.dart';

class PageOneBloc extends Bloc<PageOneEvent, PageOneState> {
  PageOneBloc() : super(PageOneInitial()) {
    on<NavigateToPageTwoEvent>(_onNavigateToPageTwoEvent);
  }

  void _onNavigateToPageTwoEvent(
      NavigateToPageTwoEvent event, Emitter<PageOneState> emit) {
    emit(NavigateToPageTwo());
  }
}
