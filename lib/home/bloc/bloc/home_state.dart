part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

abstract class HomeActionState extends HomeState {}

final class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<TodoModel> homeTodoData = todoListHome;

  HomeSuccess([homeTodoData]);
}

class HomeFailure extends HomeActionState {}

class NaviagteToWritePageFromHome extends HomeActionState {}
