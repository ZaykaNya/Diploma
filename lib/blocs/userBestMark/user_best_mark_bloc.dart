import 'package:diplom/authentication/user_repository.dart';
import 'package:diplom/blocs/userBestMark/user_best_mark_event.dart';
import 'package:diplom/blocs/userBestMark/user_best_mark_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserBestMarkBloc extends Bloc<UserBestMarkEvent, UserBestMarkState> {
  UserBestMarkBloc() : super(UserBestMarkInitial()) {
    final UserRepository _userRepository = UserRepository();

    on<GetUserBestMark>((event, emit) async {
      try {
        emit(UserBestMarkLoading());
        final userBestMark = await _userRepository.getUserBestMark(event.id, event.course);
        emit(UserBestMarkLoaded(userBestMark));
      } catch (_) {
        emit(const UserBestMarkError("Failed to fetch data"));
      }
    });
  }
}