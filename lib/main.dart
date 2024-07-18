import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techjartask/App%20Providers/user_providers.dart';
import 'package:techjartask/Service%20Provider/service_providers.dart';
import 'package:techjartask/Views/post_listing.dart';
import 'App Providers/post_providers.dart';
import 'Views/bottom_bar_view.dart';

void main() {
  runApp(const TechJarTask());
}

class TechJarTask extends StatelessWidget {
  const TechJarTask({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => PostProvider(apiService: ServiceProvider())),
        ChangeNotifierProvider(create: (context) => UserProvider(apiService: ServiceProvider()))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home:  BottomBarView(),
      ),
    );
  }
}
