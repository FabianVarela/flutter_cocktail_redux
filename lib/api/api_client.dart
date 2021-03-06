import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

class ApiClient {
  final Client _client = Client();
  final Duration _duration = Duration(seconds: 15);

  final String _apiUrl = DotEnv().env['API_URL'];
  final String _apiKey = DotEnv().env['API_KEY'];

  Future<Response> getCategoryList() async {
    final Uri uri = Uri(
      scheme: 'https',
      host: _apiUrl,
      path: '/list.php',
      queryParameters: <String, dynamic>{'c': 'list'},
    );

    final Response response =
        await _client.get(uri, headers: _setHeaders()).timeout(_duration);

    return response;
  }

  Future<Response> getDrinksByCategory(String category) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: _apiUrl,
      path: '/filter.php',
      queryParameters: <String, dynamic>{'c': category},
    );

    final Response response =
        await _client.get(uri, headers: _setHeaders()).timeout(_duration);

    return response;
  }

  Future<Response> getDetailDrink(String id) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: _apiUrl,
      path: '/lookup.php',
      queryParameters: <String, dynamic>{'i': id},
    );

    final Response response =
        await _client.get(uri, headers: _setHeaders()).timeout(_duration);

    return response;
  }

  Future<Response> getDrinkIngredient(String name) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: _apiUrl,
      path: '/search.php',
      queryParameters: <String, dynamic>{'i': name},
    );

    final Response response =
        await _client.get(uri, headers: _setHeaders()).timeout(_duration);

    return response;
  }

  Map<String, String> _setHeaders() {
    return <String, String>{
      'x-rapidapi-host': _apiUrl,
      'x-rapidapi-key': _apiKey,
    };
  }
}
