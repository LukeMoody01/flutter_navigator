import 'package:bloc_navigation/page_one/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_navigator/flutter_navigator.dart';

class PageOne extends StatelessWidget {
  const PageOne({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const PageOne());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PageOneBloc(FlutterNavigator()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Page One'),
        ),
        body: const Center(
          child: Text(
            'This is page one',
          ),
        ),
        floatingActionButton: BlocBuilder<PageOneBloc, PageOneState>(
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
