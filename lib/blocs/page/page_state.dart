import 'package:diplom/models/branch.dart';
import 'package:equatable/equatable.dart';

abstract class PageState extends Equatable {
  const PageState();

  @override
  List<Object?> get props => [];
}

class PageInitial extends PageState {}

class PageLoading extends PageState {}

class PageLoaded extends PageState {
  final Page branch;
  const PageLoaded(this.branch);
}

class PageError extends PageState {
  final String? message;
  const PageError(this.message);
}