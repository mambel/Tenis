import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tenis/home/bloc/home_bloc.dart';
import 'package:tenis/home/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomeBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tenis App',
        initialRoute: 'home',
        routes: {
          'home': (context) => const HomePage(),
        },
        theme: ThemeData(
          primaryColor: Colors.green[700],
          colorScheme: Theme.of(context).colorScheme.copyWith(
            primary: Colors.green[900],
            onSurface: Colors.green[900],
          )
        ),
      ),
    );
  }
}
