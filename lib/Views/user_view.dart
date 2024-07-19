import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techjartask/Views/user_details_view.dart';
import '../App Providers/user_providers.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: const Text(
          "User",
          style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 22),
        ),
      ),
      body:  Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
        child: Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            if (userProvider.users.isEmpty) {
              userProvider.getUsers();
            }
            if (userProvider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: userProvider.users.length,
              itemBuilder: (context, index) {
                debugPrint("what is users length --->>>${userProvider.users.length}");
                final user = userProvider.users[index];
                return GestureDetector(
                  onTap: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDetailScreen(userId: user.id!.toInt()),
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
                              Text(user.name.toString(),
                                  style: const TextStyle(
                                      color: Colors.teal,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold)),
                              Text(user.email.toString(),
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400)),
                              Text(user.address!.city.toString(),
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400)),
                              Text(user.phone.toString(),
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400)),
                              Text(user.address!.zipcode.toString(),
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400)),
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
