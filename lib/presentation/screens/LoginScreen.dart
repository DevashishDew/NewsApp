import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:news_app/auth_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var isLoggedInOrOut = true;

  Future<bool> _onBackPressed() async {
    Navigator.of(context).pop(isLoggedInOrOut);
    return false; //<-- SEE HERE
  }

  @override
  Widget build(BuildContext context) {
    final firebaseInstance = FirebaseAuth.instance;
    final User? currentUser = firebaseInstance.currentUser;
    final photoUrl = currentUser?.photoURL ?? '';

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('User Name'),
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              photoUrl.isNotEmpty
                  ? CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          NetworkImage(currentUser?.photoURL ?? ''),
                    )
                  : const CircleAvatar(
                      radius: 60,
                      backgroundImage:
                          AssetImage('assets/images/profile_pic_avatar.webp'),
                    ),
              Text(
                currentUser?.displayName ?? '',
                style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                currentUser?.email ?? '',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: firebaseInstance.currentUser == null
                      ? Center(
                          child: ElevatedButton(
                            onPressed: () async {
                              AuthService().signInWithGoogle().then((value) {
                                setState(() {
                                  if (value.user != null) {
                                    isLoggedInOrOut = true;
                                  }
                                });
                              });
                            },
                            child: const Text('Sign-In'),
                          ),
                        )
                      : ElevatedButton(
                          child: const Text(
                            'LOG OUT',
                          ),
                          onPressed: () async {
                            AuthService().signOut().then((value) {
                              setState(() {
                                isLoggedInOrOut = true;
                              });
                            });
                          },
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
