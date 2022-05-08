import 'package:diplom/models/test.dart';
import 'package:equatable/equatable.dart';

abstract class UserTestsState extends Equatable {
  const UserTestsState();

  @override
  List<Object?> get props => [];
}

class UserTestsInitial extends UserTestsState {}

class UserTestsLoading extends UserTestsState {}

class UserTestsLoaded extends UserTestsState {
  final List<Test> userTests;
  const UserTestsLoaded(this.userTests);
}

class UserTestsError extends UserTestsState {
  final String? message;
  const UserTestsError(this.message);
}