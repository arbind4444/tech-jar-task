import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:techjartask/Models/get_comments_model.dart';
import 'package:techjartask/Models/get_user_model.dart';
import 'package:techjartask/Models/post_listing_model.dart';

import '../Models/album_model.dart';
import '../Models/todo_model.dart';
import '../Models/photo_model.dart';
import '../Models/user_post_model.dart';


class ServiceProvider {
  /// baseurl of api
  static const String baseUrl = 'https://jsonplaceholder.typicode.com';

  ///---->>Post service Provider------>>>///

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



  ///---->>User service Provider------>>>///

  Future<List<GetUserModel>> fetchUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => GetUserModel.fromJson(json)).toList();
    } else {
      throw Exception('--->>Failed to get users<---');
    }
  }

  Future<List<UserPostModel>> fetchUserPosts(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId/posts'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => UserPostModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }
  Future<List<Album>> fetchUserAlbums(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId/albums'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Album.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load albums');
    }
  }
  Future<List<Photo>> fetchAlbumPhotos(int albumId) async {
    final response = await http.get(Uri.parse('$baseUrl/albums/$albumId/photos'));
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Photo.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load photos');
    }
  }

  Future<List<UserToDoModel>> fetchUserTodos(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/users/$userId/todos'));
    debugPrint("what is to do response is ---->>>>${response.body}");
    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => UserToDoModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load todos');
    }
  }

  /// Add a new Todo
  Future<UserToDoModel> addTodoForUser(int userId, String title, bool completed) async {
    final response = await http.post(
      Uri.parse('$baseUrl/todos'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'userId': userId,
        'title': title,
        'completed': completed,
      }),
    );
    if (response.statusCode == 201) {
      return UserToDoModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add todo');
    }
  }

  Future<UserToDoModel> updateTodoForUser(int todoId, String title, bool completed) async {
    final response = await http.put(
      Uri.parse('$baseUrl/todos/$todoId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'title': title,
        'completed': completed,
      }),
    );
    if (response.statusCode == 200) {
      return UserToDoModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to update todo');
    }
  }

  // Delete a todo
  Future<void> deleteTodoForUser(int todoId) async {
    final response = await http.delete(Uri.parse('$baseUrl/todos/$todoId'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete todo');
    }
  }
}
