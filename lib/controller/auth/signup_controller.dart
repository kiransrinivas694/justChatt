import 'package:chatapp_ksn/routes/route_helper.dart';
import 'package:chatapp_ksn/view/auth/signup/signup_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  Future<void> signUp() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      print("Sign Up successful: $userCredential");

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'username': usernameController.text.trim(),
        'email': userCredential.user!.email
      });

      print("Sign Up successful: $userCredential");
      Get.offAllNamed(RouteHelper.getSigninRoute());
    } on FirebaseAuthException catch (e) {
      print("Sign Up failed: $e");
    }
  }
}
