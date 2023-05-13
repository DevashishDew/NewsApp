import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:news_app/presentation/screens/LoginScreen.dart';
import 'package:news_app/presentation/screens/favourite_screen.dart';
import 'package:news_app/presentation/screens/news_home_screen.dart';
import 'package:news_app/presentation/screens/setting_screen.dart';

class MainTabScreen extends StatefulWidget {
  const MainTabScreen({Key? key}) : super(key: key);

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _goToLoginScreen() async {
    final isLoggedIn = await Navigator.of(context)
        .push<bool>(MaterialPageRoute(builder: (ctx) => const LoginScreen()));

    if (isLoggedIn != null && isLoggedIn) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final firebaseInstance = FirebaseAuth.instance;
    late User? currentUser = firebaseInstance.currentUser;
    final photoUrl = currentUser?.photoURL ?? '';

    return Scaffold(
        appBar: AppBar(
          title: const Text('NewsApp'),
          actions: [
            InkWell(
              onTap: _goToLoginScreen,
              child: photoUrl.isNotEmpty
                  ? CircleAvatar(
                      radius: 16, // half of the desired height/width
                      backgroundImage: NetworkImage(photoUrl),
                    )
                  : const CircleAvatar(
                      radius: 16, // half of the desired height/width
                      backgroundImage:
                          AssetImage('assets/images/profile_pic_avatar.webp'),
                    ),
            ),
            const SizedBox(
              width: 8,
            )
          ],
        ),
        body: IndexedStack(
          // loads all pages at once and retains the state of pages on bottom nav
          index: _selectedPageIndex,
          children: pages,
        ),
        bottomNavigationBar: Container(
          color: Colors.black,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
            child: GNav(
              backgroundColor: Colors.black,
              color: Colors.white,
              activeColor: Colors.white,
              tabBackgroundColor: Colors.grey.shade800,
              tabs: bottomBarItemGNav,
              gap: 6,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              onTabChange: _selectPage,
            ),
          ),
        ));
  }
}

const pages = [
  NewsHomeScreen(),
  FavouriteScreen(),
  SettingsScreen(),
];

const bottomBarItemGNav = [
  GButton(icon: Icons.newspaper, text: 'Feed'),
  GButton(icon: Icons.star, text: 'Favourites'),
  GButton(icon: Icons.settings, text: 'Settings'),
];
