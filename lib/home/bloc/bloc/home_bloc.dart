import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:practicebloc/core/general_model.dart';
import 'package:practicebloc/home/ui/todo_array_home.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial()) {
    on<HomeInitialEvent>(homeInitialEvent);
    on<OnTapWriteActionButton>(onTapWriteActionButton);
    on<AddTodoList>(addTodoList);
    on<OnTapModifyButton>(onTapModifyButton);
    on<OnTapDeleteButton>(onTapDeleteButton);
  }

  FutureOr<void> homeInitialEvent(
      HomeInitialEvent event, Emitter<HomeState> emit) async {
    try {
      emit(HomeLoading());
      await Future.delayed(const Duration(seconds: 1));
      emit(HomeSuccess());
    } catch (e) {
      emit(HomeFailure());
    }
  }

  FutureOr<void> onTapWriteActionButton(
      OnTapWriteActionButton event, Emitter<HomeState> emit) {
    try {
      emit(NaviagteToWritePageFromHome());
    } catch (e) {
      emit(HomeFailure());
    }
  }

  FutureOr<void> addTodoList(AddTodoList event, Emitter<HomeState> emit) {
    try {
      todoListHome.add(event.addTodoList);
      emit(HomeSuccess(todoListHome));
    } catch (e) {
      emit(HomeFailure());
    }
  }

  FutureOr<void> onTapModifyButton(
      OnTapModifyButton event, Emitter<HomeState> emit) {
    try {
      emit(NaviagteToWritePageFromHome());
    } catch (e) {
      emit(HomeFailure());
    }
  }

  FutureOr<void> onTapDeleteButton(
      OnTapDeleteButton event, Emitter<HomeState> emit) {
    todoListHome.removeWhere((todo) => todo.id == event.deleteTodo.id);
    emit(HomeSuccess(todoListHome));
    try {} catch (e) {
      emit(HomeFailure());
    }
  }
}
