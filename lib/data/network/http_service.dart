import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/data/models/my_posts.dart';

class HttpService {
  final String _baseUrl = "https://jsonplaceholder.typicode.com/posts";
  final int _limit = 20;


  Future<List<MyPosts>> fetchPosts(int page) async {
    try {
      final response = await http.get(Uri.parse("$_baseUrl?_page=$page&_limit=$_limit"));
      if (response.statusCode == 200) {
        List<dynamic> body = jsonDecode(response.body);
        List<MyPosts> posts = body.map((item) => MyPosts.fromJson(item),).toList();
        return posts;
      } else {
        throw "Unable to retrieve posts.";
      }
    } catch (error) {
      throw Future.error(error);
    }
  }
}
