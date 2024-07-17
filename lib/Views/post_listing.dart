import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techjartask/Views/post_details_screen.dart';
import '../App Providers/post_providers.dart';

class PostListingScreen extends StatelessWidget {
  const PostListingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// app bar stands for title , leading , action for screen
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: const Text(
          "Post Listing",
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),
        ),
      ),
      /// body helps to extends middle screen ui
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        /// consumer helps to get data sequence of data by managing state of app by providers.
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
                /// GestureDetector helps to make tap actions on any Widgets
                return GestureDetector(
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) =>
                        PostDetailsScreen(postId: post.id!.toInt())));
                  },
                  child: Card(
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
                      )),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
