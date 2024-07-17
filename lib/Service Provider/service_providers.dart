import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:techjartask/Models/post_listing_model.dart';


class ServiceProvider {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<PostListingModel>> fetchPosts() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((post) => PostListingModel.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
