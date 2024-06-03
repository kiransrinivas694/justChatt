import 'package:chatapp_ksn/app/utils/app_utils.dart';
import 'package:chatapp_ksn/routes/route_helper.dart';
import 'package:chatapp_ksn/services/share_preference.dart';
import 'package:chatapp_ksn/view/auth/signup/signup_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> verifySignIn() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      print("Login successful: $userCredential");
      print("Login successful user: ${userCredential.user}");
      print("Login successful user: ${userCredential.user!.email}");

      await SharedPrefService.instance.setPrefStringValue(
          SharedPrefService.instance.username,
          userCredential.additionalUserInfo!.username ?? "");
      await SharedPrefService.instance.setPrefStringValue(
          SharedPrefService.instance.email, userCredential.user!.email ?? "");

      print(
          "printing after assigning email -> ${await getSharedPreferenceValue(SharedPrefService.instance.email)}");
      Get.offAllNamed(RouteHelper.getHomeRoute());
    } on FirebaseAuthException catch (e) {
      print("Login failed: $e");
    }
  }
}
