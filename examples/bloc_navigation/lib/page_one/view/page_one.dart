import 'package:bloc_navigation/page_one/bloc/bloc.dart';
import 'package:bloc_navigation/page_two/view/page_two.dart';
import 'package:flutter/material.dart';
import 'package:flutter_navigator/flutter_navigator.dart';

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const PageOne());
  }

  @override
  Widget build(BuildContext context) {
    final _flutterNavigator =
        FlutterNavigator(); //This should be provided by the widgets above, but this is an example
    return BlocProvider(
      create: (_) => PageOneBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Page One'),
        ),
        body: const Center(
          child: Text(
            'This is page one',
          ),
        ),
        floatingActionButton: BlocConsumer<PageOneBloc, PageOneState>(
          listener: (context, state) {
            if (state is NavigateToPageTwo) {
              _flutterNavigator.push(PageTwo.route());
            }
          },
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () {
                context.read<PageOneBloc>().add(NavigateToPageTwoEvent());
              },
              tooltip: 'Navigate',
              child: const Icon(Icons.add),
            );
          },
        ),
      ),
    );
  }
}
