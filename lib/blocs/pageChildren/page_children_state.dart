import 'package:diplom/models/branch.dart';
import 'package:equatable/equatable.dart';

abstract class PageChildrenState extends Equatable {
  const PageChildrenState();

  @override
  List<Object?> get props => [];
}

class PageChildrenInitial extends PageChildrenState {}

class PageChildrenLoading extends PageChildrenState {}

class PageChildrenLoaded extends PageChildrenState {
  final List<PageInCourse> children;
  const PageChildrenLoaded(this.children);
}

class PageChildrenError extends PageChildrenState {
  final String? message;
  const PageChildrenError(this.message);
}