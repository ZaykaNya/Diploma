import 'package:diplom/authentication/user_repository.dart';
import 'package:diplom/blocs/page/page_event.dart';
import 'package:diplom/blocs/page/page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(PageInitial()) {
    final UserRepository _userRepository = UserRepository();

    on<GetPage>((event, emit) async {
      try {
        emit(PageLoading());
        final page = await _userRepository.getPageByBranch(event.branch);
        emit(PageLoaded(page));
      } catch (_) {
        emit(const PageError("Failed to fetch data"));
      }
    });
  }
}