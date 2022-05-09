import 'package:equatable/equatable.dart';

abstract class  WeekLogsEvent extends Equatable {
  const  WeekLogsEvent();

  @override
  List<Object> get props => [];
}

class GetWeekLogs extends  WeekLogsEvent {
  final String id;
  final String time;

  const GetWeekLogs({required this.id, required this.time});
}