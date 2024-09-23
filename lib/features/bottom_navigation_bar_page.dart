import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:JobNex/core/common/widget/bottom_navigation_bar_item_widget.dart';
import 'package:JobNex/features/chat/presentation/pages/chat_page.dart';
import 'package:JobNex/features/applied_jobs/presentation/pages/applied_jobs_page.dart';
import 'package:JobNex/features/feed/presentation/pages/feed_page.dart';
import 'package:JobNex/features/feed/presentation/provider/home_navigator_provider.dart';
import 'package:JobNex/features/post/presentation/pages/post_page.dart';
import 'package:JobNex/features/profile/presentation/pages/profile_page.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:provider/provider.dart';

class BottomNavigationBarPage extends StatelessWidget {
  static const routeName = '/bottom-navigation-bar-page';
  const BottomNavigationBarPage({super.key});

  @override
  Widget build(BuildContext context) {
    final fireAuth = FirebaseAuth.instance;
    final pages = [
      const FeedPage(),
      const AppliedJobsPage(),
      const PostPage(),
      const ChatPage(),
      ProfilePage(user_id: fireAuth.currentUser!.uid),
    ];

    return ChangeNotifierProvider(
      create: (context) => HomeNavigatorProvider(),
      builder: (context, child) {
        return Scaffold(
          body: pages[context.watch<HomeNavigatorProvider>().currentpageIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex:
                context.watch<HomeNavigatorProvider>().currentpageIndex,
            onTap: (value) =>
                context.read<HomeNavigatorProvider>().changePage(value),
            items: [
              BottomNavigationBarItems.BottomNavigationBarItemWidget(
                label: "Jobs",
                icon: const Icon(Iconsax.home_1_bulk),
              ),
              BottomNavigationBarItems.BottomNavigationBarItemWidget(
                label: "Applied",
                icon: const Icon(Iconsax.briefcase_bold),
              ),
              BottomNavigationBarItems.BottomNavigationBarItemWidget(
                label: "Posts",
                icon: const Icon(Iconsax.menu_1_bold),
              ),
              BottomNavigationBarItems.BottomNavigationBarItemWidget(
                label: "Chat",
                icon: const Icon(Iconsax.message_2_bulk),
              ),
              BottomNavigationBarItems.BottomNavigationBarItemWidget(
                label: "Profile",
                icon: const Icon(Iconsax.profile_tick_bold),
              ),
            ],
          ),
        );
      },
    );
  }
}
