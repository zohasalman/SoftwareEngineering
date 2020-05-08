import 'package:firebase_auth/firebase_auth.dart';
import 'package:rateit/user.dart';
import 'package:rateit/firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();
  final GoogleSignIn googleSignIn = GoogleSignIn();

  // create user obj based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // sign in with email and password
  Future signInEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      if (user.isEmailVerified){
        return _userFromFirebaseUser(user);
      }else{
        return null;
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword(String firstName, String lastName, String gender, DateTime date, String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      await _firestoreService.registerUser(UserData(
        uid: result.user.uid ?? '',
        firstName: firstName ?? '',
        lastName: lastName ?? '',
        gender: gender ?? '',
        dateOfBirth: date ?? '',
        email: email ?? '',
        userRole: 'user',
        profilePicture: 'https://firebasestorage.googleapis.com/v0/b/seproject-rateit.appspot.com/o/UserData%2Fuser.png?alt=media&token=7a421d2a-af9b-479a-82f7-92ef593da922',
        ));
      FirebaseUser user = result.user;
      try{
        await user.sendEmailVerification();
      }catch(e){
        print("An error occured while trying to send email verification.");
        return e.message;
      }
      if (user.isEmailVerified){
        return _userFromFirebaseUser(user);
      }else{
        return 'Needs verification.';
      }
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Forgot password
  Future<String> resetPassword(String email) async {
    try{
      await _auth.sendPasswordResetEmail(email: email);
      return null; 
    }catch(e){
      return 'User record not found'; 
    }
  }

   // Sign In with Google 
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: [
          'email'
        ],
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
      await _firestoreService.registerUser(UserData(
        uid: user.uid ?? '',
        firstName: 'First Name',
        lastName: 'Last Name',
        gender: 'NA',
        dateOfBirth: DateTime.now(),
        email: 'myemail@example.com',
        userRole: 'user',
        profilePicture: 'https://firebasestorage.googleapis.com/v0/b/seproject-rateit.appspot.com/o/UserData%2Fuser.png?alt=media&token=7a421d2a-af9b-479a-82f7-92ef593da922',
        ));
      print("signed in " + user.displayName);

      return user;
    }catch (e) {
      print(e.message);
    }
  }

  // Sign In with Facebook
  Future<void> signInWithFacebook() async{
    try {
      var facebookLogin = new FacebookLogin();
      var result = await facebookLogin.logIn(['email']);

      if(result.status == FacebookLoginStatus.loggedIn) {
        final AuthCredential credential = FacebookAuthProvider.getCredential(
          accessToken: result.accessToken.token,

        );
        final FirebaseUser user = (await FirebaseAuth.instance.signInWithCredential(credential)).user;
        await _firestoreService.registerUser(UserData(
          uid: user.uid ?? '',
          firstName: 'First Name',
          lastName: 'Last Name',
          gender: 'NA',
          dateOfBirth: DateTime.now(),
          email: 'myemail@example.com',
          userRole: 'user',
          profilePicture: 'https://firebasestorage.googleapis.com/v0/b/seproject-rateit.appspot.com/o/UserData%2Fuser.png?alt=media&token=7a421d2a-af9b-479a-82f7-92ef593da922',
          ));
        print('signed in ' + user.displayName);
        return user;
      }
    }catch (e) {
      print(e.message);
    }
  }
}