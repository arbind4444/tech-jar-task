import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techjartask/App%20Providers/user_providers.dart';
import 'package:techjartask/Views/post_listing.dart';
import 'package:techjartask/Views/user_view.dart';

import 'bottom_bar.dart';

class BottomBarView extends StatelessWidget {
   BottomBarView({super.key});

  final List<Widget> _tabWidgets = [
    const PostListingScreen(),
    const UserView()

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<UserProvider>(
        builder: (context, tabProvider, _) => _tabWidgets[tabProvider.currentIndex],
      ),
        bottomNavigationBar:const BottomBar()
    );
  }
}

