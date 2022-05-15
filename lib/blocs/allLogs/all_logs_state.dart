import 'package:diplom/models/log.dart';
import 'package:equatable/equatable.dart';

abstract class AllLogsState extends Equatable {
  const AllLogsState();

  @override
  List<Object?> get props => [];
}

class AllLogsInitial extends AllLogsState {}

class AllLogsLoading extends AllLogsState {}

class AllLogsLoaded extends AllLogsState {
  final List<UserLog> allLogs;
  const AllLogsLoaded(this.allLogs);
}

class AllLogsError extends AllLogsState {
  final String? message;
  const AllLogsError(this.message);
}