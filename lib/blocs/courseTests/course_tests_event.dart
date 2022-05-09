import 'package:equatable/equatable.dart';

abstract class CourseTestsEvent extends Equatable {
  const CourseTestsEvent();

  @override
  List<Object> get props => [];
}

class GetCourseTests extends CourseTestsEvent {
  final String course;

  const GetCourseTests({required this.course});
}