import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:practicebloc/home/bloc/bloc/home_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  void didChangeDependencies() {
    context.read<HomeBloc>().add(HomeInitialEvent());
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listenWhen: (previous, current) => current is HomeActionState,
      buildWhen: (previous, current) => current is! HomeActionState,
      listener: (context, homeListen) {
        if (homeListen is NaviagteToWritePageFromHome) {
          Navigator.pushNamed(context, 'WritePage');
        } else if (homeListen is HomeFailure) {
          Navigator.pushNamed(context, 'error');
        }
      },
      builder: (context, homeBuild) {
        if (isLoading) {
          return const Skeletonizer(
            containersColor: Color.fromARGB(255, 31, 32, 32),
            effect:
                ShimmerEffect(baseColor: Color.fromARGB(255, 124, 124, 126)),
            child: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        } else if (homeBuild is HomeLoading) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else if (homeBuild is HomeSuccess) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Todo'),
            ),
            body: Column(
              children: [
                Expanded(
                  child: SlidableAutoCloseBehavior(
                    child: ListView.builder(
                      itemCount: homeBuild.homeTodoData.length,
                      itemBuilder: (context, index) {
                        return Slidable(
                          closeOnScroll: true,
                          key: ValueKey(homeBuild.homeTodoData[index].id),
                          startActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            dismissible: DismissiblePane(onDismissed: () {
                              context.read<HomeBloc>().add(OnTapDeleteButton(
                                  deleteTodo: homeBuild.homeTodoData[index]));
                            }),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  context.read<HomeBloc>().add(
                                      OnTapDeleteButton(
                                          deleteTodo:
                                              homeBuild.homeTodoData[index]));
                                },
                                backgroundColor: const Color(0xFFFE4A49),
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (context) {
                                  context.read<HomeBloc>().add(
                                      OnTapModifyButton(
                                          modifyTodo:
                                              homeBuild.homeTodoData[index]));
                                },
                                backgroundColor: const Color(0xFF0392CF),
                                foregroundColor: Colors.white,
                                icon: Icons.save,
                                label: 'Modify',
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: Text(
                                homeBuild.homeTodoData[index].id.toString()),
                            title: Text(homeBuild.homeTodoData[index].title),
                            subtitle:
                                Text(homeBuild.homeTodoData[index].subtitle),
                            trailing:
                                Text(homeBuild.homeTodoData[index].timeAndDate),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<HomeBloc>().add(OnTapWriteActionButton());
                  },
                  child: const Text('Add New Todo'),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
