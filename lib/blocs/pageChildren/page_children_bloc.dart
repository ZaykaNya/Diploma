import 'package:diplom/authentication/user_repository.dart';
import 'package:diplom/blocs/pageChildren/page_children_event.dart';
import 'package:diplom/blocs/pageChildren/page_children_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PageChildrenBloc extends Bloc<PageChildrenEvent, PageChildrenState> {
  PageChildrenBloc() : super(PageChildrenInitial()) {
    final UserRepository _userRepository = UserRepository();

    on<GetPageChildren>((event, emit) async {
      try {
        emit(PageChildrenLoading());
        final children = await _userRepository.getPageChildrenByBranch(event.branch);
        emit(PageChildrenLoaded(children));
      } catch (_) {
        emit(const PageChildrenError("Failed to fetch data"));
      }
    });
  }
}