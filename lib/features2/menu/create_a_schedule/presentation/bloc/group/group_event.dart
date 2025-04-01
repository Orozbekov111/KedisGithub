part of 'group_bloc.dart';

abstract class GroupEvent extends Equatable {
  const GroupEvent();

  @override
  List<Object> get props => [];
}

class CreateGroupEvent extends GroupEvent {
  final String groupName;

  const CreateGroupEvent(this.groupName);

  @override
  List<Object> get props => [groupName];
}