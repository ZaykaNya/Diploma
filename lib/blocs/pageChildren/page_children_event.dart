import 'package:equatable/equatable.dart';

abstract class PageChildrenEvent extends Equatable {
  const PageChildrenEvent();

  @override
  List<Object> get props => [];
}

class GetPageChildren extends PageChildrenEvent {
  final String branch;

  const GetPageChildren({required this.branch});
}