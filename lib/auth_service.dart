import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:news_app/presentation/screens/LoginScreen.dart';
import 'package:news_app/presentation/screens/main_tab_screen.dart';

class AuthService {

  final googleSignIn = GoogleSignIn();

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final googleUser = await googleSignIn.signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
    await googleUser!.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  //Sign out
  Future<void> signOut() async{
    await googleSignIn.signOut();
    return FirebaseAuth.instance.signOut();
  }

  Future<bool> isUserAuthenticated() async{
    return FirebaseAuth.instance.currentUser != null;
  }

  //Determine if the user is authenticated.
  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return MainTabScreen();
          } else {
            return const LoginScreen();
          }
        });
  }
}
