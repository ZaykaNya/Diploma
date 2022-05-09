import 'package:diplom/models/test.dart';
import 'package:equatable/equatable.dart';

abstract class CourseTestsState extends Equatable {
  const CourseTestsState();

  @override
  List<Object?> get props => [];
}

class CourseTestsInitial extends CourseTestsState {}

class CourseTestsLoading extends CourseTestsState {}

class CourseTestsLoaded extends CourseTestsState {
  final List<Test> courseTests;
  const CourseTestsLoaded(this.courseTests);
}

class CourseTestsError extends CourseTestsState {
  final String? message;
  const CourseTestsError(this.message);
}