import 'package:bloc/bloc.dart';
import 'package:diplom/navigation/constants/nav_bar_items.dart';
import 'package:diplom/navigation/navigation_state.dart';


class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState(NavbarItem.statistics, 0));

  void getNavBarItem(NavbarItem navbarItem) {
    switch (navbarItem) {
      case NavbarItem.statistics:
        emit(const NavigationState(NavbarItem.statistics, 0));
        break;
      case NavbarItem.progress:
        emit(const NavigationState(NavbarItem.progress, 1));
        break;
      case NavbarItem.history:
        emit(const NavigationState(NavbarItem.history, 2));
        break;
    }
  }
}