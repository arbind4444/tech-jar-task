import 'package:flutter/material.dart';
import 'package:techjartask/Models/get_comments_model.dart';
import '../Models/post_listing_model.dart';
import '../Service Provider/service_providers.dart';

class PostProvider with ChangeNotifier{

  final ServiceProvider apiService;

  PostProvider({required this.apiService});

 /// handle get post listing model
  List<PostListingModel> _posts = [];
  List<PostListingModel> get posts => _posts;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// fetch post listing data
  Future<void> postListing() async {
    _isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
    _posts = await apiService.getPostListing();
    _isLoading = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }

  /// handle comments models

  List<GetCommentModel> _comments = [];
  List<GetCommentModel> get comments => _comments;

  /// fetch post details comments  data
  Future<void> getCommentsListing(int postId) async {
    _isLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
    _comments = await apiService.getComments(postId);
    _isLoading = false;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });
  }
}