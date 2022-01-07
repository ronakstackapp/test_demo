import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';



class Authentication {

  ///FireBase_GoogleSignIn
  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    User? user;
    print("Authentication -- class");
    FirebaseAuth auth = FirebaseAuth.instance;
    // FireBaseUserModel? model;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    bool isSignedIn = await googleSignIn.isSignedIn();

    if(isSignedIn){
      print("googleSignIn -->> isSignedIn -->>$isSignedIn");
      // if so, return the current user
      user = auth.currentUser;
      ScaffoldMessenger.of(context).showSnackBar(
        Authentication.customSnackBar(
          content: 'AllReady Login_  ${user!.email} ',
        ),
      );

    }else {
      final GoogleSignInAccount? googleSignInAccount =
      await googleSignIn.signIn();


      if (googleSignInAccount != null) {
        print("Authentication -- class  0");
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
          await auth.signInWithCredential(credential);

          ScaffoldMessenger.of(context).showSnackBar(
            Authentication.customSnackBar(
              content: 'Done',
            ),
          );

          print("User Data --> ${userCredential.user}");
          user = userCredential.user;
          // model = userCredential.user as FireBaseUserModel?;
          // print("model Data --> ${model!.uId}");

        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {

          }
          else if (e.code == 'invalid-credential') {
            // handle the error here
          }
        } catch (e) {
          // handle the error here
        }
      }
    }

    return user;
  }

  ///FireBase_GoogleLogOut
  static Future<void> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn();

    try {

        await googleSignIn.signOut();
        ScaffoldMessenger.of(context).showSnackBar(
          Authentication.customSnackBar(
            content: 'signing out.',
          ),
        );

    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        Authentication.customSnackBar(
          content: 'Error signing out. Try again.',
        ),
      );
    }
  }

  static SnackBar customSnackBar({required String content}) {
    return SnackBar(
      backgroundColor: Colors.black,
      content: Text(
        content,
        style:const TextStyle(color: Colors.redAccent, letterSpacing: 0.5),
      ),
    );
  }



  static  Future<void> phoneSignIn({required String phoneNumber,required PhoneVerificationCompleted verificationCompleted,required PhoneVerificationFailed verificationFailed,required PhoneCodeSent codeSent,required PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    print("phoneSignIn -->>$phoneNumber");
    await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  // static Future<String?> facebookSignin() async {
  //   void initiateFacebookLogin() async {
  //     var facebookLogin = FacebookLogin();
  //     var facebookLoginResult =
  //     await facebookLogin.logInWithReadPermissions(['email']);
  //     switch (facebookLoginResult.status) {
  //       case FacebookLoginStatus.error:
  //         print("Error");
  //         onLoginStatusChanged(false);
  //         break;
  //       case FacebookLoginStatus.cancelledByUser:
  //         print("CancelledByUser");
  //         onLoginStatusChanged(false);
  //         break;
  //       case FacebookLoginStatus.loggedIn:
  //         print("LoggedIn");
  //         onLoginStatusChanged(true);
  //         break;
  //     }
  //   }
  //
  // }
  //
  // void onLoginStatusChanged(bool isLoggedIn) {
  //   setState(() {
  //     this.isLoggedIn = isLoggedIn;
  //   });
  // }

}