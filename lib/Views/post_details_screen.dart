import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../App Providers/post_providers.dart';

class PostDetailsScreen extends StatelessWidget {
  final int postId;
  const PostDetailsScreen({super.key,required this.postId});

  @override
  Widget build(BuildContext context) {
    debugPrint("what is postId --->>>>${postId.toString()}");
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        /// inkwell helps to make tap function
        leading: InkWell(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: const Icon(Icons.arrow_back,color: Colors.white)),
        backgroundColor: Colors.blueGrey,
        title: const Text('Post Details/comments',
            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Consumer<PostProvider>(
          builder: (context, postProvider, child) {
            if(postProvider.comments.isEmpty){
              postProvider.getCommentsListing(postId);
            }
            if (postProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: postProvider.comments.length,
              itemBuilder: (context, index) {
                debugPrint("what is comments length --->>>>${postProvider.comments.length}");
                final comment = postProvider.comments[index];
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
                            Text(comment.name.toString(),
                                style: const TextStyle(
                                    color: Colors.teal,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            Text("Email:${comment.email.toString()}",
                                style: const TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            Text(comment.body.toString(),
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
          }
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint("add comments");
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
