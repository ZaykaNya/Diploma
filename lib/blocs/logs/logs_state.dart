import 'package:diplom/models/log.dart';
import 'package:equatable/equatable.dart';

abstract class LogsState extends Equatable {
  const LogsState();

  @override
  List<Object?> get props => [];
}

class LogsInitial extends LogsState {}

class LogsLoading extends LogsState {}

class LogsLoaded extends LogsState {
  final List<UserLog> logs;
  const LogsLoaded(this.logs);
}

class LogsError extends LogsState {
  final String? message;
  const LogsError(this.message);
}