part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class OnTapWriteActionButton extends HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class AddTodoList extends HomeEvent {
  final TodoModel addTodoList;
  AddTodoList(this.addTodoList);
}

class OnTapModifyButton extends HomeEvent {
  final TodoModel modifyTodo;
  OnTapModifyButton({required this.modifyTodo});
}

class OnTapDeleteButton extends HomeEvent {
  final TodoModel deleteTodo;
  OnTapDeleteButton({required this.deleteTodo});
}
