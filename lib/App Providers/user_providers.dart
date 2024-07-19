import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:techjartask/Models/get_user_model.dart';
import 'package:techjartask/Models/todo_model.dart';
import '../Models/album_model.dart';
import '../Models/photo_model.dart';
import '../Models/user_post_model.dart';
import '../Service Provider/service_providers.dart';


class UserProvider with ChangeNotifier {
  /// instance of network request
  final ServiceProvider apiService;
  UserProvider({required this.apiService});
  /// Home BottomBar ///
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  void changeTab(int index) {
    _currentIndex = index;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  /// user getter method

  List<GetUserModel> _users = [];
  List<GetUserModel> get users => _users;


  List<UserPostModel> _userPosts = [];
  List<UserPostModel> get userPosts => _userPosts;

  List<UserToDoModel> _userTodos = [];
  List<UserToDoModel> get userTodos => _userTodos;

  List<Album> _userAlbums = [];
  List<Album> get userAlbums => _userAlbums;

  List<Photo> _albumPhotos = [];
  List<Photo> get albumPhotos => _albumPhotos;

  /// network loader
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// fetch user list
  Future<void> getUsers() async {
    _isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    _users = await apiService.fetchUsers();

    _isLoading = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
  Future<void> getUserPosts({int? userId}) async {
    _isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

     _userPosts = await apiService.fetchUserPosts(userId!);

    _isLoading = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  Future<void> getUserTodos({int? userId}) async {
    _isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    _userTodos = await apiService.fetchUserTodos(userId!);

    _isLoading = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  Future<void> getUserAlbums({int? userId}) async {
    _isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    _userAlbums = await apiService.fetchUserAlbums(userId!);

    _isLoading = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  Future<void> getAlbumPhotos({int? albumId}) async {
    _isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    _albumPhotos = await apiService.fetchAlbumPhotos(albumId!);

    _isLoading = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  Future addTodoForUser({int? userId, String? title, bool? completed}) async {
    final newTodo = await apiService.addTodoForUser(userId!, title!, completed!);
     _userTodos.add(UserToDoModel(
       id: newTodo.id,
       userId: newTodo.userId,
       title: newTodo.title,
       completed: newTodo.completed
     ));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  Future updateTodoForUser(
      {int? todoId, String? title, bool? completed}) async {
    final updatedTodo = await apiService.updateTodoForUser(todoId!, title!, completed!);
    final index = _userTodos.indexWhere((todo) => todo.id == todoId);
    if (index != -1) {
      _userTodos[index] = updatedTodo;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        notifyListeners();
      });
    }
  }

  Future deleteTodoForUser({int? todoId}) async {
    await apiService.deleteTodoForUser(todoId!);
    _userTodos.removeWhere((todo) => todo.id == todoId);
    notifyListeners();
  }

}