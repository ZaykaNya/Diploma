import 'package:equatable/equatable.dart';

abstract class CourseEvent extends Equatable {
  const CourseEvent();

  @override
  List<Object> get props => [];
}

class GetCourse extends CourseEvent {
  final String course;

  const GetCourse({required this.course});
}