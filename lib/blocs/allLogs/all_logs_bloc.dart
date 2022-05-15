import 'package:diplom/authentication/user_repository.dart';
import 'package:diplom/blocs/allLogs/all_logs_event.dart';
import 'package:diplom/blocs/allLogs/all_logs_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllLogsBloc extends Bloc<AllLogsEvent, AllLogsState> {
  AllLogsBloc() : super(AllLogsInitial()) {
    final UserRepository _userRepository = UserRepository();

    on<GetAllLogs>((event, emit) async {
      try {
        emit(AllLogsLoading());
        final allLogs = await _userRepository.getAllLogs();
        emit(AllLogsLoaded(allLogs));
      } catch (_) {
        emit(const AllLogsError("Failed to fetch data"));
      }
    });
  }
}