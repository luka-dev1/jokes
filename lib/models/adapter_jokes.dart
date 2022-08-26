/// Adapter interface that represents every API that can be used.
///
/// It makes it easier to add new API's in the future.
abstract class JokesAdapter {
  /// Title of the current joke category. Set by classes that implement
  /// this interface.
  late final String title;

  /// Fetches jokes from an external API.
  Future<String> fetchJoke();
}
