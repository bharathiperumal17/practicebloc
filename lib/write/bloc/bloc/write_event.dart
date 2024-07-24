part of 'write_bloc.dart';

@immutable
sealed class WriteEvent {}

class WriteButtonPressed extends WriteEvent {
  final TodoModel addDataToTodoList;
  WriteButtonPressed({required this.addDataToTodoList});
}

class WriteIntialEvent extends WriteEvent {}
