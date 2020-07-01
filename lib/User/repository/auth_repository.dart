import 'package:firebase_auth/firebase_auth.dart';
import 'package:platzi_trips_app/User/repository/firebase_auth_api.dart';

class AuthRepository{
  final FirebaseAuthAPI firebaseAuthAPI = FirebaseAuthAPI();
  Future<FirebaseUser> signIngFireBase() => firebaseAuthAPI.googleSignIn();
  singOut() => firebaseAuthAPI.signOut();
}