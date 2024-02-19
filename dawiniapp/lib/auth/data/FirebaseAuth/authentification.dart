// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:dartz/dartz.dart';
import 'package:dawini_full/auth/data/models/auth_model.dart';
import 'package:dawini_full/core/error/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // FOR EVERY FUNCTION HERE
  // POP THE ROUTE USING: Navigator.of(context).pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);

  // GET USER DATA
  // using null check operator since this method should be called only
  // when the user is logged in
  User get user => _auth.currentUser!;

  // STATE PERSISTENCE STREAM
  Stream<User?> get authState => FirebaseAuth.instance.authStateChanges();
  // OTHER WAYS (depends on use case):
  // Stream get authState => FirebaseAuth.instance.userChanges();
  // Stream get authState => FirebaseAuth.instance.idTokenChanges();
  // KNOW MORE ABOUT THEM HERE: https://firebase.flutter.dev/docs/auth/start#auth-state

  // EMAIL SIGN UP
  Future<Either<Failure, UserCredential>> signUpWithEmail(
      {required AuthModel authData}) async {
    try {
      await sendEmailVerification();

      return Right(await _auth.createUserWithEmailAndPassword(
        email: authData.email,
        password: authData.password,
      ));
    } on FirebaseAuthException catch (e) {
      // if you want to display your own custom error message
      if (e.code == 'weak-password') {
        if (kDebugMode) {
          print('The password provided is too weak.');
        }
        return Left(AuthenticatinFailure(
            message: "The password provided is too weak."));
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        return Left(AuthenticatinFailure(
            message: "The account already exists for that email."));
      } else {
        return Left(AuthenticatinFailure(message: e.code));
      }
    }
  }

  // EMAIL LOGIN
  Future<Either<Failure, UserCredential>> loginWithEmail(
      {required AuthModel authData}) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: authData.email,
        password: authData.password,
      );
      if (!user.emailVerified) {
        await sendEmailVerification();
        // restrict access to certain things using provider
        // transition to another page instead of home screen
      }
      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(AuthenticatinFailure(message: e.message.toString()));
    }
  }

  // EMAIL VERIFICATION
  Future<Either<Failure, String>> sendEmailVerification() async {
    try {
      _auth.currentUser!.sendEmailVerification();
      return const Right('Email verification sent!');
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(message: e.message.toString()));
    }
  }

  // GOOGLE SIGN IN
  // Future<void> signInWithGoogle(BuildContext context) async {
  //   try {
  //     if (kIsWeb) {
  //       GoogleAuthProvider googleProvider = GoogleAuthProvider();

  //       googleProvider
  //           .addScope('https://www.googleapis.com/auth/contacts.readonly');

  //       await _auth.signInWithPopup(googleProvider);
  //     } else {
  //       final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

  //       final GoogleSignInAuthentication? googleAuth =
  //           await googleUser?.authentication;

  //       if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
  //         // Create a new credential
  //         final credential = GoogleAuthProvider.credential(
  //           accessToken: googleAuth?.accessToken,
  //           idToken: googleAuth?.idToken,
  //         );
  //         UserCredential userCredential =
  //             await _auth.signInWithCredential(credential);

  //         // if you want to do specific task like storing information in firestore
  //         // only for new users using google sign in (since there are no two options
  //         // for google sign in and google sign up, only one as of now),
  //         // do the following:

  //         // if (userCredential.user != null) {
  //         //   if (userCredential.additionalUserInfo!.isNewUser) {}
  //         // }
  //       }
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     showSnackBar(context, e.message!); // Displaying the error message
  //   }
  // }

  // // // ANONYMOUS SIGN IN
  // Future<void> signInAnonymously(BuildContext context) async {
  //   try {
  //     await _auth.signInAnonymously();
  //   } on FirebaseAuthException catch (e) {
  //     showSnackBar(context, e.message!); // Displaying the error message
  //   }
  // }

  // FACEBOOK SIGN IN
  // Future<void> signInWithFacebook(BuildContext context) async {
  //   try {
  //     final LoginResult loginResult = await FacebookAuth.instance.login();

  //     final OAuthCredential facebookAuthCredential =
  //         FacebookAuthProvider.credential(loginResult.accessToken!.token);

  //     await _auth.signInWithCredential(facebookAuthCredential);
  //   } on FirebaseAuthException catch (e) {
  //     showSnackBar(context, e.message!); // Displaying the error message
  //   }
  // }

  // // PHONE SIGN IN
  // Future<void> phoneSignIn(
  //   BuildContext context,
  //   String phoneNumber,
  // ) async {
  //   TextEditingController codeController = TextEditingController();
  //   if (kIsWeb) {
  //     // !!! Works only on web !!!
  //     ConfirmationResult result =
  //         await _auth.signInWithPhoneNumber(phoneNumber);

  //     // Diplay Dialog Box To accept OTP
  //     showOTPDialog(
  //       codeController: codeController,
  //       context: context,
  //       onPressed: () async {
  //         PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //           verificationId: result.verificationId,
  //           smsCode: codeController.text.trim(),
  //         );

  //         await _auth.signInWithCredential(credential);
  //         Navigator.of(context).pop(); // Remove the dialog box
  //       },
  //     );
  //   } else {
  //     // FOR ANDROID, IOS
  //     await _auth.verifyPhoneNumber(
  //       phoneNumber: phoneNumber,
  //       //  Automatic handling of the SMS code
  //       verificationCompleted: (PhoneAuthCredential credential) async {
  //         // !!! works only on android !!!
  //         await _auth.signInWithCredential(credential);
  //       },
  //       // Displays a message when verification fails
  //       verificationFailed: (e) {
  //         showSnackBar(context, e.message!);
  //       },
  //       // Displays a dialog box when OTP is sent
  //       codeSent: ((String verificationId, int? resendToken) async {
  //         showOTPDialog(
  //           codeController: codeController,
  //           context: context,
  //           onPressed: () async {
  //             PhoneAuthCredential credential = PhoneAuthProvider.credential(
  //               verificationId: verificationId,
  //               smsCode: codeController.text.trim(),
  //             );

  //             // !!! Works only on Android, iOS !!!
  //             await _auth.signInWithCredential(credential);
  //             Navigator.of(context).pop(); // Remove the dialog box
  //           },
  //         );
  //       }),
  //       codeAutoRetrievalTimeout: (String verificationId) {
  //         // Auto-resolution timed out...
  //       },
  //     );
  //   }
  // }

  // SIGN OUT
  Future<Either<Failure, void>> signOut() async {
    try {
      await _auth.signOut();
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(message: e.code));
    }
  }

  // DELETE ACCOUNT
  Future<Either<Failure, void>> deleteAccount(BuildContext context) async {
    try {
      await _auth.currentUser!.delete();
      return const Right(null);
    } on FirebaseAuthException catch (e) {
      return Left(ServerFailure(message: e.code));
      // showSnackBar(context, e.message!); // Displaying the error message
      // if an error of requires-recent-login is thrown, make sure to log
      // in user again and then delete account.
    }
  }
}
