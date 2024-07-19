import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../App Providers/post_providers.dart';

class PostDetailsScreen extends StatelessWidget {
  final int postId;
   PostDetailsScreen({super.key,required this.postId});

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _bodyController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    debugPrint("what is postId --->>>>${postId.toString()}");
    final postProvider = Provider.of<PostProvider>(context);
    /// Fetch comments if not already loaded
    if (postProvider.comments.isEmpty && !postProvider.isLoading) {
      postProvider.getCommentsListing(postId: postId);
    }
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
              postProvider.getCommentsListing(postId: postId);
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
          _showAddCommentDialog(context, postProvider);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
  void _showAddCommentDialog(BuildContext context, PostProvider postProvider) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Comment'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _bodyController,
                  decoration: const InputDecoration(labelText: 'Comment'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a comment';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  postProvider.addComment(
                    postId: postId,
                    name: _nameController.text,
                    email: _emailController.text,
                    body: _bodyController.text
                  ).then((_) {
                    Navigator.of(context).pop();
                    _nameController.clear();
                    _emailController.clear();
                    _bodyController.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar( backgroundColor: Colors.green,
                          content: Text('Comment added!'
                          ,style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w500),
                          )),
                    );
                  }).catchError((error) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Failed to add comment')),
                    );
                  });
                }
              },
              child: const Text('add comments'),
            ),
          ],
        );
      },
    );
  }
}
