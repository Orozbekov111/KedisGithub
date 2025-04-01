part of 'group_bloc.dart';

abstract class GroupState extends Equatable {
  const GroupState();

  @override
  List<Object> get props => [];
}

class GroupInitial extends GroupState {}

class GroupLoading extends GroupState {}

class GroupCreated extends GroupState {
  final String groupId;

  const GroupCreated(this.groupId);

  @override
  List<Object> get props => [groupId];
}

class GroupError extends GroupState {
  final String message;

  const GroupError(this.message);

  @override
  List<Object> get props => [message];
}