import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practicebloc/core/route.dart';
import 'package:practicebloc/core/themeColor.dart';
import 'package:practicebloc/home/bloc/bloc/home_bloc.dart';
import 'package:practicebloc/write/bloc/bloc/write_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
        ),
        BlocProvider<WriteBloc>(
          create: (context) => WriteBloc(context.read<HomeBloc>()),
          child: Container(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppThemeColor.primary),
          useMaterial3: true,
        ),
        initialRoute: '/',
        onGenerateRoute: AppRoute().onGenerateRoute,
      ),
    );
  }
}
