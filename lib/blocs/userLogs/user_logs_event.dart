import 'package:equatable/equatable.dart';

abstract class UserLogsEvent extends Equatable {
  const UserLogsEvent();

  @override
  List<Object> get props => [];
}

class GetUserLogs extends UserLogsEvent {
  final String id;

  const GetUserLogs({required this.id});
}