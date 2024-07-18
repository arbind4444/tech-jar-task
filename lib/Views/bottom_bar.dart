import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techjartask/App%20Providers/user_providers.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, tabProvider, _) => Container(
        height: 65.0,
        decoration:  BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          color: Colors.blueGrey.withOpacity(0.5),
        ),
        child: Padding(
          padding:  const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () => tabProvider.changeTab(0),
                child: SizedBox(
                  height: 60,
                  width: 70,
                  child:tabProvider.currentIndex == 0?
                  const Icon(Icons.post_add_rounded,color: Colors.teal):const Icon(Icons.post_add_rounded,color: Colors.blueGrey),
                ),
              ),
              InkWell(
                onTap: () => tabProvider.changeTab(1),
                child: SizedBox(
                  height: 60,
                  width: 70,
                  child:tabProvider.currentIndex == 1?
                  const Icon(Icons.home,color: Colors.teal):const Icon(Icons.home,color: Colors.blueGrey),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
