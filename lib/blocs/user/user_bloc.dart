import 'package:diplom/authentication/user_repository.dart';
import 'package:diplom/blocs/user/user_event.dart';
import 'package:diplom/blocs/user/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserInitial()) {
    final UserRepository _userRepository = UserRepository();

    on<GetUser>((event, emit) async {
      try {
        emit(UserLoading());
        final user = await _userRepository.getUserById(event.id);
        emit(UserLoaded(user));
      } catch (_) {
        emit(const UserError("Logout"));
      }
    });
  }
}