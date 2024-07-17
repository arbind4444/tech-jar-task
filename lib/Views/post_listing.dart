import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../App Providers/post_providers.dart';

class PostListingScreen extends StatelessWidget {
  const PostListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PostProvider>(
        builder: (context, postProvider, child) {
          if (postProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: postProvider.posts.length,
            itemBuilder: (context, index) {
              final post = postProvider.posts[index];
              return ListTile(
                title: Text(post.title.toString()),
                subtitle: Text(post.body.toString()),
              );
            },
          );
        },
      ),
    );
  }
}
