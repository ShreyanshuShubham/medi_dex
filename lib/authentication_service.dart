import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth auth;

  AuthenticationService(this.auth);

  /// Changed to idTokenChanges as it updates depending on more cases.
  Stream<User?> get authStateChanges => auth.idTokenChanges();

  /// This won't pop routes so you could do something like
  /// Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  /// after you called this method if you want to pop all routes.
  Future<void> signOut() async {
    await auth.signOut();
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<String> signIn({required String email,required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      // return e.message;
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else{
        return 'Unknown Error';
      }
    }
  }

  /// There are a lot of different ways on how you can do exception handling.
  /// This is to make it as easy as possible but a better way would be to
  /// use your own custom class that would take the exception and return better
  /// error messages. That way you can throw, return or whatever you prefer with that instead.
  Future<String> signUp({required String email,required String password}) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      return "Signed up";
    } on FirebaseAuthException catch (e) {
      // return e.message;
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else{
        return 'Unknown Error';
      }
    }
  }
}