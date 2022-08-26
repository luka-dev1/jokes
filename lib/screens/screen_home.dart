import 'package:flutter/material.dart';
import 'package:jokes/widgets/dialog_email_list.dart';
import 'package:jokes/widgets/widget_category_picker.dart';
import 'package:jokes/widgets/widget_joke_content.dart';
import 'package:jokes/widgets/widget_send_emails.dart';
import 'package:provider/provider.dart';

import '../models/joke.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isInit = true;

  /// Loads a joke if the screen is initializing for the first time.
  @override
  void didChangeDependencies() {
    if (_isInit) {
      var joke = Provider.of<Joke>(context, listen: false);
      joke.setContent();
      _isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromRGBO(221, 214, 243, 1.0),
            Color.fromRGBO(250, 172, 168, 1.0),
          ],
        ),
      ),
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: screenWidth > 800 ? 800 : screenWidth,
              child: Column(
                children: [
                  /// Upper part of the app where all app categories
                  /// are displayed.
                  const Flexible(
                    flex: 1,
                    fit: FlexFit.tight,
                    child: CategoryPicker(),
                  ),

                  /// Central part displays the joke.
                  ///
                  /// Bottom part displays buttons for sending emails,
                  /// viewing email list and reloading anew joke.
                  Flexible(
                    flex: 9,
                    fit: FlexFit.tight,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Stack(
                        children: [
                          /// Current joke category.
                          Align(
                            alignment: Alignment.topCenter,
                            child: Consumer<Joke>(
                              builder: (context, joke, child) {
                                return Text(joke.adapter.title);
                              },
                            ),
                          ),

                          /// Joke content.
                          const Center(
                            child: JokeContent(),
                          ),

                          /// Buttons on the left.
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Row(
                              children: [
                                /// Button that shows the email list dialog.
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (_) => const EmailListDialog(),
                                    );
                                  },
                                  child: const Icon(
                                    Icons.list_alt_rounded,
                                    size: 50,
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),

                                /// Button that loads a new joke from an API.
                                GestureDetector(
                                  onTap: () {
                                    var joke = Provider.of<Joke>(context,
                                        listen: false);
                                    joke.setContent();
                                  },
                                  child: const Icon(
                                    Icons.restart_alt,
                                    size: 50,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          /// Button that triggers an external API for
                          /// sending emails.
                          const Align(
                            alignment: Alignment.bottomRight,
                            child: SendEmails(),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
