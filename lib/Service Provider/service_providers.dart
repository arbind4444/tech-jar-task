import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:techjartask/Models/get_comments_model.dart';
import 'package:techjartask/Models/post_listing_model.dart';


class ServiceProvider {
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  Future<List<PostListingModel>> getPostListing() async {
    final response = await http.get(Uri.parse('$baseUrl/posts'));
    debugPrint("what is body response ----->>>${response.body}");
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      debugPrint("what is post response ----->>>$jsonResponse");
      return jsonResponse.map((post) => PostListingModel.fromJson(post)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<List<GetCommentModel>> getComments(int postId) async {
    final response = await http.get(Uri.parse('$baseUrl/posts/$postId/comments'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((comment) => GetCommentModel.fromJson(comment)).toList();
    } else {
      throw Exception('-------Failed to get comments------');
    }
  }
}
