import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:techjartask/Models/get_comments_model.dart';
import 'package:techjartask/Models/post_listing_model.dart';


class ServiceProvider {
  /// baseurl of api
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  /// request post listing data from server
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
  /// request comments listing data from server
  Future<List<GetCommentModel>> getComments(int postId) async {
    final response = await http.get(Uri.parse('$baseUrl/posts/$postId/comments'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((comment) => GetCommentModel.fromJson(comment)).toList();
    } else {
      throw Exception('-------Failed to get comments------');
    }
  }

  /// request add comments by id to server.
  Future<GetCommentModel> addCommentById(int postId, String name, String email, String body) async {
    final response = await http.post(Uri.parse('$baseUrl/posts/$postId/comments'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'body': body,
      }),
    );
    debugPrint("what is add comments response is ----->>${response.body}");
    debugPrint("what is add comments statusCode is ----->>${response.statusCode}");
    if (response.statusCode == 201) {
      return GetCommentModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add comment');
    }
  }
}
