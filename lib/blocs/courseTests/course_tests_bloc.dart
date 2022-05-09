import 'package:diplom/authentication/user_repository.dart';
import 'package:diplom/blocs/courseTests/course_tests_event.dart';
import 'package:diplom/blocs/courseTests/course_tests_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CourseTestsBloc extends Bloc<CourseTestsEvent, CourseTestsState> {
  CourseTestsBloc() : super(CourseTestsInitial()) {
    final UserRepository _userRepository = UserRepository();

    on<GetCourseTests>((event, emit) async {
      try {
        emit(CourseTestsLoading());
        final courseTests = await _userRepository.getCourseTests(event.course);
        emit(CourseTestsLoaded(courseTests));
      } catch (_) {
        emit(const CourseTestsError("Failed to fetch data"));
      }
    });
  }
}