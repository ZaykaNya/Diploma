import 'package:diplom/models/log.dart';
import 'package:equatable/equatable.dart';

abstract class WeekLogsState extends Equatable {
  const WeekLogsState();

  @override
  List<Object?> get props => [];
}

class  WeekLogsInitial extends WeekLogsState {}

class  WeekLogsLoading extends WeekLogsState {}

class  WeekLogsLoaded extends WeekLogsState {
  final List<UserLog> userWeekLogs;
  const  WeekLogsLoaded(this.userWeekLogs);
}

class  WeekLogsError extends WeekLogsState {
  final String? message;
  const  WeekLogsError(this.message);
}