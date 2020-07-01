import 'package:firebase_auth/firebase_auth.dart';
import 'package:generic_bloc_provider/generic_bloc_provider.dart';
import 'package:platzi_trips_app/User/repository/auth_repository.dart';

class UserBloc implements Bloc {
  final _auth_repository = AuthRepository();
Stream <FirebaseUser> streamFirebaseUser = FirebaseAuth.instance.onAuthStateChanged;
Stream <FirebaseUser> get authStatus => streamFirebaseUser;
  //Casos de uso

  //1 sign in con google
  Future<FirebaseUser> signIn() {
    return _auth_repository.signIngFireBase();
  }

  signOut(){
    _auth_repository.singOut();
  }

  @override
  void dispose() {
    // TODO: implement dispose
  }
}
