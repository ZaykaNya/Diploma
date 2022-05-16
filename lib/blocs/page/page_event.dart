import 'package:equatable/equatable.dart';

abstract class PageEvent extends Equatable {
  const PageEvent();

  @override
  List<Object> get props => [];
}

class GetPage extends PageEvent {
  final String branch;

  const GetPage({required this.branch});
}