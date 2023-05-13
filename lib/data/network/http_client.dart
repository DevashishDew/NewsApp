import 'dart:convert';
import 'package:http/http.dart' as http;

class BaseHttpClient {
  final _baseUrl = 'https://jsonplaceholder.typicode.com/posts';
  final int _limit = 20;

  Future<List<dynamic>> fetchPosts(int page) async {
    try {
      final res =
          await http.get(Uri.parse("$_baseUrl?_page=$page&_limit=$_limit"));
      if (res.statusCode == 200) {
        final posts = json.decode(res.body);
        return posts;
      } else {
        throw Exception('Could not fetch posts!');
      }
    } catch (err) {
      throw Exception('Something went wrong!');
    }
  }

}
