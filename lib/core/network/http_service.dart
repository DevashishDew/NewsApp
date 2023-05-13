import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/data/models/my_posts.dart';

class HttpService {
  final String postsURL = "https://jsonplaceholder.typicode.com/posts";

  Future<List<MyPosts>> getPosts() async {
    try {
      final response = await http.get(Uri.parse(postsURL));
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
