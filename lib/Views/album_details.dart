import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../App Providers/user_providers.dart';


class AlbumDetailScreen extends StatelessWidget {
  final int albumId;
  const AlbumDetailScreen({super.key, required this.albumId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
        title: const Text(
          "Album Photos",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Consumer<UserProvider>(builder: (context, userProvider, child) {
          if (userProvider.albumPhotos.isEmpty) {
            userProvider.getAlbumPhotos(albumId: albumId);
          }
          if (userProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: userProvider.albumPhotos.length,
            itemBuilder: (context, index) {
              final photo = userProvider.albumPhotos[index];
              debugPrint('photo----->>>>:${photo.thumbnailUrl.toString()}');
              return Card(
                elevation: 1,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: Column(
                    children: [
                      Text(photo.title,style: const TextStyle(color: Colors.blueGrey,fontSize: 15,fontWeight: FontWeight.w500),),
                      Image.network(
                        photo.url,
                        errorBuilder: (context, error, stackTrace) {
                          return const Center(
                            child: Icon(
                              Icons.error,
                              color: Colors.red,
                              size: 50,
                            ),
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Center(
                              child: CircularProgressIndicator(
                                value: loadingProgress.expectedTotalBytes != null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          }
                        },
                      ),

                    ],
                  ),
                ),
              );
            },
          );
        }),
      )
    );
  }
}
