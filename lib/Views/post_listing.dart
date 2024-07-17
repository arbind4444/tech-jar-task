import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../App Providers/post_providers.dart';

class PostListingScreen extends StatelessWidget {
  const PostListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: const Text(
          "Post Listing",
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: Consumer<PostProvider>(
          builder: (context, postProvider, child) {
            if (postProvider.posts.isEmpty) {
              postProvider.postListing();
            }
            if (postProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: postProvider.posts.length,
              itemBuilder: (context, index) {
                debugPrint("what is post length --->>>${postProvider.posts.length}");
                final post = postProvider.posts[index];
                /// card is used for elevated container for better ui experience which extending container for postListing data
                return Card(
                    color: const Color(0xFFFFFFFF),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(post.title.toString(),
                                style: const TextStyle(
                                    color: Colors.teal,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            Text(post.body.toString(),
                                textAlign: TextAlign.start,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400))
                          ],
                        ),
                      ),
                    ));
              },
            );
          },
        ),
      ),
    );
  }
}
