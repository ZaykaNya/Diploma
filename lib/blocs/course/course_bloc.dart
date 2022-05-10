import 'package:diplom/authentication/user_repository.dart';
import 'package:diplom/blocs/course/course_event.dart';
import 'package:diplom/blocs/course/course_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseBloc extends Bloc<CourseEvent, CourseState> {
  CourseBloc() : super(CourseInitial()) {
    final UserRepository _userRepository = UserRepository();

    on<GetCourse>((event, emit) async {
      try {
        emit(CourseLoading());
        final course = await _userRepository.getCourse(event.course);
        emit(CourseLoaded(course));
      } catch (_) {
        emit(const CourseError("Failed to fetch data"));
      }
    });
  }
}