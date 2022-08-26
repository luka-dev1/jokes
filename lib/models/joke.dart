import 'package:flutter/material.dart';
import 'package:jokes/models/adapter_chuck_norris.dart';
import 'package:jokes/models/adapter_dad_jokes.dart';
import 'package:jokes/models/adapter_jokes.dart';

/// A provider class that holds a joke to be displayed.
///
/// It implements a ChangeNotifier mixin which gives it a functionality
/// to notify (provide) all interested widgets in the tree
/// of the changes that occur.
class Joke with ChangeNotifier {
  /// Content of a Joke.
  String _content = "";

  /// Boolean value indicating if the joke is currently loading from an API.
  bool _isLoading = true;

  /// Adapter property which controls which category of jokes
  /// is being downloaded and displayed.
  ///
  /// Initially,the Chuck Norris API is used through the ChuckNorrisAdapter.
  JokesAdapter _adapter = ChuckNorrisAdapter();

  /// List of all the possible API's the app can use represented
  /// by their adapter classes.
  final List<JokesAdapter> _adapters = [
    ChuckNorrisAdapter(),
    DadJokesAdapter(),
  ];

  /// Getters.
  String get content => _content;
  bool get isLoading => _isLoading;
  JokesAdapter get adapter => _adapter;
  List<JokesAdapter> get adapters => _adapters;

  /// Loads a new joke.
  Future<void> setContent() async {
    /// Indicates that the loading is in progress.
    setIsLoading(true);

    /// Fetches the joke through the currently chosen adapter.
    var content = await _adapter.fetchJoke();

    /// If the content comes back empty notifies the user that something
    /// went wrong by displaying the error message on the screen instead
    /// of teh jokes content.
    if (content.isEmpty) {
      content = "Something went wrong. Please try again.";
    }

    /// Sets the new content.
    _content = content;

    /// Indicates that the loading is completed.
    setIsLoading(false);
  }

  /// Notifies consumer widgets about the loading state of the joke.
  void setIsLoading(bool value) {
    _isLoading = value;
    Future.microtask(() => notifyListeners());
  }

  /// Sets the chosen adapter.
  void setAdapter(JokesAdapter adapter) {
    _adapter = adapter;
  }
}
