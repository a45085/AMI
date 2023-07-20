import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  String? getCurrentUser() {
    if (currentUser != null) {
      return currentUser!.uid;
    } else {
      final googleUser = _googleSignIn.currentUser;
      if (googleUser != null) {
        return googleUser.id;
      } else {
        return null;
      }
    }
  }

  Future<String> registerWithEmailAndPassword(
      String email, String password) async {
    final user = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    return user.user!.uid;
  }

  Future<void> deleteUser() async {
    try {
      if (currentUser != null) {
        await currentUser!.delete();
      }
    } catch (e) {
      print('Erro ao excluir o usuário: $e');
    }
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    final user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<String> googleHandleSignIn() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential userCredential =
        await _auth.signInWithCredential(credential);
    return userCredential.user!.uid;
  }

  Future<void> signOut() async {
    if (currentUser != null) {
      await _auth.signOut();
    } else {
      _googleSignIn.signOut();
    }
  }
}
