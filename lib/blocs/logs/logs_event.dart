import 'package:equatable/equatable.dart';

abstract class LogsEvent extends Equatable {
  const LogsEvent();

  @override
  List<Object> get props => [];
}

class GetLogsFromTime extends LogsEvent {
  final String id;
  final String time;

  const GetLogsFromTime({required this.id, required this.time});
}