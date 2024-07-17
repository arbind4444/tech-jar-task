import 'package:flutter/material.dart';
import '../Models/post_listing_model.dart';
import '../Service Provider/service_providers.dart';

class PostProvider with ChangeNotifier{

  final ServiceProvider apiService;

  PostProvider({required this.apiService});

  List<PostListingModel> _posts = [];
  List<PostListingModel> get posts => _posts;


  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> fetchPosts() async {
    _isLoading = true;
    notifyListeners();

    _posts = await apiService.fetchPosts();

    _isLoading = false;
    notifyListeners();
  }
}