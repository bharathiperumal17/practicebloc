import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:practicebloc/core/general_model.dart';
import 'package:practicebloc/home/bloc/bloc/home_bloc.dart';
import 'package:practicebloc/home/ui/todo_array_home.dart';

part 'write_event.dart';
part 'write_state.dart';

class WriteBloc extends Bloc<WriteEvent, WriteState> {
  final HomeBloc homeBloc;
  WriteBloc(this.homeBloc) : super(WriteInitial()) {
    on<WriteIntialEvent>(writeInitialEvent);
    on<WriteButtonPressed>(writeButtonPressed);
  }

  FutureOr<void> writeInitialEvent(
      WriteIntialEvent event, Emitter<WriteState> emit) async {
    try {
      emit(WriteLoading());
      emit(WriteSucess(buttonName: 'Add To TodoList'));
    } catch (e) {
      emit(WriteError());
    }
  }

  FutureOr<void> writeButtonPressed(
      WriteButtonPressed event, Emitter<WriteState> emit) async {
    try {
      emit(WriteSucess(buttonName: 'Add To TodoList'));
      List<TodoModel> newTodoList = List.from(todoListHome);
      newTodoList.add(event.addDataToTodoList);
      homeBloc.add(AddTodoList(event.addDataToTodoList));
      emit(BackToHome());
    } catch (e) {
      emit(WriteError());
    }
  }
}
