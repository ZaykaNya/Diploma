import 'package:equatable/equatable.dart';

abstract class UserBestMarkEvent extends Equatable {
  const UserBestMarkEvent();

  @override
  List<Object> get props => [];
}

class GetUserBestMark extends UserBestMarkEvent {
  final String id;
  final String course;

  const GetUserBestMark({required this.id, required this.course});
}