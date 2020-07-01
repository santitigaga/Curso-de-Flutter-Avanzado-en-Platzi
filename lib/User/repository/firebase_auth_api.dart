import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthAPI {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<FirebaseUser> googleSignIn() async {
    await signOut();
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount
        .authentication;

    AuthResult authResult = await _auth.signInWithCredential(
        GoogleAuthProvider.getCredential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken)
    );
    FirebaseUser user = await authResult.user;

    return user;
  }

  void signOut() async  {
  await _auth.signOut().then((onValue) => print("Sesion cerrada"));
  _googleSignIn.signOut();
  print("sesiones cerradadas");
  }


/*  Future<FirebaseUser> facebookSignIn() async {
    final result = await _facebookLogin.logInWithReadPermissions(['email']);

    switch (result.status) {
    caseFacebookLoginStatus.loggedIn
    :{
    AuthResult authResult = await _auth.signInWithCredential(
    FacebookAuthProvider.getCredential(accessToken: result.accessToken.token)
    );

    FirebaseUser user = authResult.user;

    return user;
    break;
    }

    caseFacebookLoginStatus.cancelledByUser:{
    print("cancelado por usuario");
    break;
    }

    caseFacebookLoginStatus.error:{
    print("Error: "+result.errorMessage.toString());
    break;
    }
  }
  }*/

  Future<FirebaseUser> emailAndPasswordSignIn(String email,
      String password) async {
    AuthResult authResult = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    FirebaseUser user = authResult.user;

    return user;
  }
}