import 'package:diplom/authentication/user_repository.dart';
import 'package:diplom/blocs/logs/logs_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logs_state.dart';

class LogsBloc extends Bloc<LogsEvent, LogsState> {
  LogsBloc() : super(LogsInitial()) {
    final UserRepository _userRepository = UserRepository();

    on<GetLogsFromTime>((event, emit) async {
      try {
        emit(LogsLoading());
        final logs = await _userRepository.getUserLogsFromTime(event.id, event.time);
        emit(LogsLoaded(logs));
      } catch (_) {
        emit(const LogsError("Failed to fetch data"));
      }
    });
  }
}