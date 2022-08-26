import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/joke.dart';

/// Widget that displays a joke.
class JokeContent extends StatefulWidget {
  const JokeContent({Key? key}) : super(key: key);

  @override
  State<JokeContent> createState() => _JokeContentState();
}

class _JokeContentState extends State<JokeContent> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Joke>(
      builder: (context, joke, child) {
        if (!joke.isLoading) {
          return Text(
            joke.content,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
            ),
          );
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
