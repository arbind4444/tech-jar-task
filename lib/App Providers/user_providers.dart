import 'package:flutter/material.dart';
import 'package:techjartask/Models/get_user_model.dart';

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

  /// network loader
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  /// fetch user list
  Future<void> getUsers() async {
    _isLoading = true;
    notifyListeners();

    _users = await apiService.fetchUsers();

    _isLoading = false;
    notifyListeners();
  }


}