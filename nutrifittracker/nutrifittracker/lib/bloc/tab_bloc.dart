// tab_bloc.dart

import 'package:bloc/bloc.dart';
import 'package:riverpod/riverpod.dart';

final indexBottomNavbarProvider = StateProvider<int>((ref) {
  return 0;
});

enum TabEvent { home, search, profile }

class TabBloc extends Bloc<TabEvent, int> {
  TabBloc() : super(0);

  @override
  Stream<int> mapEventToState(TabEvent event) async* {
    switch (event) {
      case TabEvent.home:
        yield 0;
        break;
      case TabEvent.search:
        yield 1;
        break;
      case TabEvent.profile:
        yield 2;
        break;
    }
  }
}
