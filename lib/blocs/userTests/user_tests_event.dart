import 'package:equatable/equatable.dart';

abstract class UserTestsEvent extends Equatable {
  const UserTestsEvent();

  @override
  List<Object> get props => [];
}

class GetUserTests extends UserTestsEvent {
  final String id;

  const GetUserTests({required this.id});
}