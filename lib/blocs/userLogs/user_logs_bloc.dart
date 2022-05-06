import 'package:diplom/authentication/user_repository.dart';
import 'package:diplom/blocs/userLogs/user_logs_event.dart';
import 'package:diplom/blocs/userLogs/user_logs_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserLogsBloc extends Bloc<UserLogsEvent, UserLogsState> {
  UserLogsBloc() : super(UserLogsInitial()) {
    final UserRepository _userRepository = UserRepository();

    on<GetUserLogs>((event, emit) async {
      try {
        emit(UserLogsLoading());
        final userLogs = await _userRepository.getUserLogsById(event.id);
        emit(UserLogsLoaded(userLogs));
      } catch (_) {
        emit(const UserLogsError("Failed to fetch data"));
      }
    });
  }
}