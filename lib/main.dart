import 'package:flutter/material.dart';
import 'package:jokes/models/email_list.dart';
import 'package:jokes/models/joke.dart';
import 'package:jokes/screens/screen_home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Joke()),
        ChangeNotifierProvider(create: (context) => EmailList()),
      ],
      child: const MyApp(),
    ),
  );
}

/// A single page app that displays different kinds of jokes.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jokes',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
      ),
      home: const HomeScreen(),
    );
  }
}
