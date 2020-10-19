import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:password_strength/password_strength.dart';
import 'package:http/http.dart' as http;
import 'models/SubscriptionResponse.dart';

final FirebaseAuth auth = FirebaseAuth.instance;

Future<UserCredential> signInWithGoogle() async {
  // Trigger the authentication flow
  final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

  // Obtain the auth details from the request
  final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  // Create a new credential
  final GoogleAuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  // Once signed in, return the UserCredential
  return await auth.signInWithCredential(credential);
}

Future<UserCredential> signInWithFacebook() async {
  // Trigger the sign-in flow
  final LoginResult result = await FacebookAuth.instance.login();

  // Create a credential from the access token
  final FacebookAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(result.accessToken.token);

  // Once signed in, return the UserCredential
  return await auth.signInWithCredential(facebookAuthCredential);
}

Future<bool> hasMembership() async {
  final http.Response response = await http.post(
    'https://thepond.howtohockey.com/wp-content/themes/meltingpot-child/active-membership.php',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'email': auth.currentUser.email,
    }),
  );
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    SubscriptionResponse subResponse = SubscriptionResponse.fromJson(jsonDecode(response.body));
    return subResponse.subscriptions.length > 0;
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load membership');
  }
}

Future<void> signOut() async {
  await auth.signOut();
}

bool emailVerified() {
  auth.currentUser.reload();
  return auth.currentUser.emailVerified;
}

bool validEmail(String email) {
  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
}

bool validPassword(String pass) {
  return estimatePasswordStrength(pass) > 0.7;
}
