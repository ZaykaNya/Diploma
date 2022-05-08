import 'package:diplom/authentication/user_repository.dart';
import 'package:diplom/blocs/userTests/user_tests_event.dart';
import 'package:diplom/blocs/userTests/user_tests_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserTestsBloc extends Bloc<UserTestsEvent, UserTestsState> {
  UserTestsBloc() : super(UserTestsInitial()) {
    final UserRepository _userRepository = UserRepository();

    on<GetUserTests>((event, emit) async {
      try {
        emit(UserTestsLoading());
        final userTests = await _userRepository.getUserTestsResult(event.id);
        emit(UserTestsLoaded(userTests));
      } catch (_) {
        emit(const UserTestsError("Failed to fetch data"));
      }
    });
  }
}