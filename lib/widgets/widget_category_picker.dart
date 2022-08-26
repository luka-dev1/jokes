import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/joke.dart';

/// Clickable and scrollable list of joke categories. By clicking on a
/// certain category that categories API is called
/// and the new joke is displayed.
class CategoryPicker extends StatefulWidget {
  const CategoryPicker({Key? key}) : super(key: key);

  @override
  State<CategoryPicker> createState() => _CategoryPickerState();
}

class _CategoryPickerState extends State<CategoryPicker> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.purpleAccent.withOpacity(0.1),
          ),
        ),
      ),
      child: Consumer<Joke>(
        builder: (context, joke, child) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: joke.adapters.length,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  /// Circular, clickable container that represent a category.
                  AspectRatio(
                    aspectRatio: 1.0,
                    child: GestureDetector(
                      onTap: () {
                        joke.setAdapter(joke.adapters[index]);
                        joke.setContent();
                      },
                      child: Container(
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: Center(
                          child: Text(
                            joke.adapters[index].title,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
