import 'package:equatable/equatable.dart';

abstract class AllLogsEvent extends Equatable {
  const AllLogsEvent();

  @override
  List<Object> get props => [];
}

class GetAllLogs extends AllLogsEvent {
  const GetAllLogs();
}