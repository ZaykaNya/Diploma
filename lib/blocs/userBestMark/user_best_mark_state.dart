import 'package:diplom/models/mark.dart';
import 'package:equatable/equatable.dart';

abstract class UserBestMarkState extends Equatable {
  const UserBestMarkState();

  @override
  List<Object?> get props => [];
}

class UserBestMarkInitial extends UserBestMarkState {}

class UserBestMarkLoading extends UserBestMarkState {}

class UserBestMarkLoaded extends UserBestMarkState {
  final Mark userBestMark;
  const UserBestMarkLoaded(this.userBestMark);
}

class UserBestMarkError extends UserBestMarkState {
  final String? message;
  const UserBestMarkError(this.message);
}