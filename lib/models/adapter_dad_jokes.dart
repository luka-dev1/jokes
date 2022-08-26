import 'dart:convert';

import 'package:jokes/models/adapter_jokes.dart';
import 'package:http/http.dart' as http;

/// Adapter class that fetches dad jokes from an external API.
class DadJokesAdapter implements JokesAdapter {
  final _url = 'https://icanhazdadjoke.com/';

  @override
  String title = "Dad Jokes";

  @override
  Future<String> fetchJoke() async {
    try {
      var url = Uri.parse(_url);
      var response = await http.get(
        headers: {'Accept': 'application/json'},
        url,
      );
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      var data = json.decode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        return data['joke'];
      }
    } on Exception catch (e) {
      print(e);
    }
    return "";
  }
}
