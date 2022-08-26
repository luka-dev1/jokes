import 'package:jokes/models/adapter_chuck_norris.dart';
import 'package:jokes/models/adapter_dad_jokes.dart';
import 'package:jokes/models/joke.dart';
import 'package:test/test.dart';

void main() {
  group("Joke", () {
    test('should initialize Chuck Norris adapter.', () {
      final joke = Joke();
      expect(joke.adapter is ChuckNorrisAdapter, true);
    });

    test('should initialize empty content.', () {
      final joke = Joke();
      expect(joke.content, "");
    });

    test('.setIsLoading() should set isLoading to correct value.', () {
      final joke = Joke();
      joke.setIsLoading(false);
      expect(joke.isLoading, false);
    });

    test('.setAdapter() should set correct adapter.', () {
      final joke = Joke();
      var dadJokes = DadJokesAdapter();
      joke.setAdapter(dadJokes);
      expect(joke.adapter is DadJokesAdapter, true);
    });
  });
}
