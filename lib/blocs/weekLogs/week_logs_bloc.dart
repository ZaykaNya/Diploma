import 'package:diplom/authentication/user_repository.dart';
import 'package:diplom/blocs/weekLogs/week_logs_event.dart';
import 'package:diplom/blocs/weekLogs/week_logs_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeekLogsBloc extends Bloc< WeekLogsEvent,  WeekLogsState> {
  WeekLogsBloc() : super(WeekLogsInitial()) {
    final UserRepository _userRepository = UserRepository();

    on<GetWeekLogs>((event, emit) async {
      try {
        emit(WeekLogsLoading());
        final userWeekLogs = await _userRepository.getUserLogsFromTime(event.id, event.time);
        emit(WeekLogsLoaded(userWeekLogs));
      } catch (_) {
        emit(const WeekLogsError("Failed to fetch data"));
      }
    });
  }
}