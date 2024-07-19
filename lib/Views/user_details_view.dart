import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techjartask/App%20Providers/user_providers.dart';
import 'album_details.dart';

class UserDetailScreen extends StatelessWidget {
  final int userId;
  const UserDetailScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.blueGrey,
          centerTitle: true,
          title: const Text(
            "User Details",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
          ),
          bottom: const TabBar(
            labelStyle: TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
            tabs: [
              Tab(text: 'Posts'),
              Tab(text: 'Todos'),
              Tab(text: 'Albums'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildPostsTab(userId: userId),
            _buildTodosTab(userId: userId),
            _buildAlbumsTab(userId: userId),
          ],
        ),
      ),
    );
  }

  Widget _buildPostsTab({int? userId}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Consumer<UserProvider>(builder: (context, userProvider, child) {
        if (userProvider.userPosts.isEmpty) {
          userProvider.getUserPosts(userId: userId);
        }
        if (userProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: userProvider.userPosts.length,
          itemBuilder: (context, index) {
            final userPost = userProvider.userPosts[index];
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
                        Text(userPost.title.toString(),
                            style: const TextStyle(
                                color: Colors.teal,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        Text(userPost.body.toString(),
                            style: const TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ));
          },
        );
      }),
    );
  }

  Widget _buildTodosTab({int? userId}) {
    return Consumer<UserProvider>(builder: (context, userProvider, child) {
      if (userProvider.userTodos.isEmpty) {
        userProvider.getUserTodos(userId: userId);
      }
      if (userProvider.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }

      return ListView.builder(
        itemCount: userProvider.userTodos.length,
        itemBuilder: (context, index) {
          final toDo = userProvider.userTodos[index];
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(toDo.title.toString(),
                              style: const TextStyle(
                                  color: Colors.teal,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                          Checkbox(
                            value: toDo.completed,
                            onChanged: (bool? value) {
                              userProvider.updateTodoForUser(
                                todoId:toDo.id,
                                title:toDo.title,
                                completed: value ?? false
                              ).then((value) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(backgroundColor: Colors.green,
                                      content: Text('User update successFully !!',style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white,
                                        fontSize: 18
                                      ),)),
                                );
                              });
                            },
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: ElevatedButton(
                              onPressed: () {
                                bool isCompleted = false;
                                _showAddTodoDialog(context, userProvider,isCompleted);
                              } ,
                              child: const Text('Add Todo'),
                            ),
                          ),
                          InkWell(
                              onTap: (){
                                userProvider.deleteTodoForUser(
                                  todoId: toDo.id
                                ).then((value) {
                                  userProvider.getUserTodos(userId: userId);
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(backgroundColor: Colors.red,
                                        content: Text('User deleted successFully !!',style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                            fontSize: 18
                                        ),)),
                                  );
                                });
                              },
                              child: const Icon(Icons.delete,size: 50,color: Colors.red,))
                        ],
                      ),
                    ],
                  ),
                ),
              ));
        },
      );
    });
  }

  void _showAddTodoDialog(BuildContext context, UserProvider userProvider, bool isCompleted) {
    final TextEditingController titleController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Add Todo'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Form(
                key: formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a title';
                        }
                        return null;
                      },
                    ),
                    Row(
                      children: [
                        const Text('Completed'),
                        Checkbox(
                          value: isCompleted,
                          onChanged: (bool? value) {
                            setState(() {
                              isCompleted = value ?? false;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (formKey.currentState?.validate() ?? false) {
                  userProvider.addTodoForUser(
                    userId: userId,
                    title:  titleController.text,
                    completed:  isCompleted,
                  ).then((value) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(backgroundColor: Colors.green,
                          content: Text('User added successFully !!',style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 18
                          ),)),
                    );
                    Navigator.of(context).pop();
                  });
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAlbumsTab({int? userId}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Consumer<UserProvider>(builder: (context, userProvider, child) {
        if (userProvider.userAlbums.isEmpty) {
          userProvider.getUserAlbums(userId: userId);
        }
        if (userProvider.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: userProvider.userAlbums.length,
          itemBuilder: (context, index) {
                 final album = userProvider.userAlbums[index];
            return InkWell(
               onTap: (){
                 Navigator.push(
                   context,
                   MaterialPageRoute(
                     builder: (context) =>
                         AlbumDetailScreen(albumId: album.id),
                   ),
                 );
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
                          Text(album.title.toString(),
                              style: const TextStyle(
                                  color: Colors.teal,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  )),
            );
          },
        );
      }),
    );
  }
}
