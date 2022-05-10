import 'package:diplom/models/course.dart';
import 'package:equatable/equatable.dart';

abstract class CourseState extends Equatable {
  const CourseState();

  @override
  List<Object?> get props => [];
}

class CourseInitial extends CourseState {}

class CourseLoading extends CourseState {}

class CourseLoaded extends CourseState {
  final Course course;
  const CourseLoaded(this.course);
}

class CourseError extends CourseState {
  final String? message;
  const CourseError(this.message);
}