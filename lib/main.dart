import 'package:flutter/material.dart';
import 'package:techjartask/Views/post_listing.dart';

void main() {
  runApp(const TechJarTask());
}

class TechJarTask extends StatelessWidget {
  const TechJarTask({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PostListingScreen(),
    );
  }
}
