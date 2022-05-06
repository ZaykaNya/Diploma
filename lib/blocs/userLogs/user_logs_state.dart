import 'package:diplom/models/log.dart';
import 'package:equatable/equatable.dart';

abstract class UserLogsState extends Equatable {
  const UserLogsState();

  @override
  List<Object?> get props => [];
}

class UserLogsInitial extends UserLogsState {}

class UserLogsLoading extends UserLogsState {}

class UserLogsLoaded extends UserLogsState {
  final List<UserLog> userLogs;
  const UserLogsLoaded(this.userLogs);
}

class UserLogsError extends UserLogsState {
  final String? message;
  const UserLogsError(this.message);
}