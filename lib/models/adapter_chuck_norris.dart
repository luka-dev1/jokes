import 'dart:convert';
import 'package:jokes/models/adapter_jokes.dart';
import 'package:http/http.dart' as http;

/// Adapter class that fetches Chuck Norris jokes from an external API.
class ChuckNorrisAdapter implements JokesAdapter {
  final _url = 'http://api.icndb.com/jokes/random';

  @override
  String title = "Chuck Norris";

  @override
  Future<String> fetchJoke() async {
    try {
      var url = Uri.parse(_url);
      var response = await http.get(url);
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      var data = json.decode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        return data['value']['joke'];
      }
    } on Exception catch (e) {
      print(e);
    }
    return "";
  }
}
