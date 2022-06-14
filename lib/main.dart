import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sample_api/services/boredServices.dart';
import 'package:sample_api/services/connectivityServices.dart';
import 'home/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learn Bloc Implementation with Bored API',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
              create: (context) => BoredService()
          ),
          RepositoryProvider(
              create: (context) => ConnectivityServices()
          ),
        ],
        child: const HomePage(),
      )
    );
  }
}
