import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicebloc/core/general_model.dart';
import 'package:practicebloc/home/bloc/bloc/home_bloc.dart';
import 'package:practicebloc/home/ui/todo_array_home.dart';
import 'package:practicebloc/write/bloc/bloc/write_bloc.dart';
import 'package:practicebloc/write/ui/textfield_widget.dart';

class WriteScreen extends StatefulWidget {
  const WriteScreen({super.key});

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  @override
  void didChangeDependencies() {
    context.read<WriteBloc>().add(WriteIntialEvent());
    super.didChangeDependencies();
  }

  TextEditingController title = TextEditingController(text: '');
  TextEditingController subTitle = TextEditingController(text: '');
  TextEditingController timeAndDate = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WriteBloc, WriteState>(
      listenWhen: (previous, current) => current is WriteActionState,
      buildWhen: (previous, current) => current is! WriteActionState,
      listener: (context, state) {
        if (state is BackToHome) {
          Navigator.pop(context);
        } else {
          Navigator.pushNamed(context, 'Error');
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case const (WriteLoading):
            return Scaffold(
              appBar: AppBar(
                title: const Text('Write Screen'),
              ),
              body: const Center(
                child: CircularProgressIndicator(),
              ),
            );

          case const (WriteSucess):
            final writestate = state as WriteSucess;
            return Scaffold(
                appBar: AppBar(
                  title: const Text('Write Screen'),
                ),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFieldWidget(
                      textController: title,
                      hintText: 'Title',
                    ),
                    TextFieldWidget(
                      textController: subTitle,
                      hintText: 'content',
                    ),
                    TextFieldWidget(
                      textController: timeAndDate,
                      hintText: 'Scheduling Time',
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          int maxId = todoListHome.isNotEmpty
                              ? todoListHome.map((todo) => todo.id).fold(
                                  0,
                                  (prev, element) =>
                                      element > prev ? element : prev)
                              : 0;
                          int newId = maxId + 1;

                          context.read<WriteBloc>().add(WriteButtonPressed(
                              addDataToTodoList: TodoModel(
                                  id: newId,
                                  title: title.text,
                                  subtitle: subTitle.text,
                                  timeAndDate: timeAndDate.text)));

                          title.clear();
                          subTitle.clear();
                          timeAndDate.clear();
                        },
                        child: Text(writestate.buttonName))
                  ],
                ));
          default:
            return Container();
        }
      },
    );
  }
}
