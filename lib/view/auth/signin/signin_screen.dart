import 'package:chatapp_ksn/app/widget/app_image_assets.dart';
import 'package:chatapp_ksn/app/widget/app_text.dart';
import 'package:chatapp_ksn/app/widget/app_text_form_field.dart';
import 'package:chatapp_ksn/constant/app_asset.dart';
import 'package:chatapp_ksn/constant/app_colors.dart';
import 'package:chatapp_ksn/controller/auth/signin_controller.dart';
import 'package:chatapp_ksn/routes/route_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SignInController>(
        init: SignInController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.white,
            body: Container(
              height: double.infinity,
              width: double.infinity,
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            width: 30.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                AppText(
                                  "Login",
                                  color: AppColorConstant.appBlack,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20.px,
                                ),
                                const SizedBox(
                                  height: 7,
                                ),
                                const AppText(
                                    "Login to access your justChatt  account"),
                                const SizedBox(
                                  height: 20,
                                ),
                                AppTextFormField(
                                    hintText: "Email",
                                    textEditingController:
                                        controller.emailController),
                                const SizedBox(
                                  height: 20,
                                ),
                                AppTextFormField(
                                    hintText: "Password",
                                    textEditingController:
                                        controller.passwordController),
                                const SizedBox(
                                  height: 20,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    controller.verifySignIn();
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    color: AppColorConstant.blue1,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: const Center(
                                      child: AppText(
                                        "Login",
                                        color: AppColorConstant.appWhite,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Align(
                                  alignment: Alignment.center,
                                  child: GestureDetector(
                                    onTap: () {
                                      Get.offAllNamed(
                                          RouteHelper.getSignupRoute());
                                    },
                                    child: AppText(
                                      "Don't Have an account ? Sign Up",
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      AppImageAsset(
                        image: "images/login_showcase.png",
                        width: 30.w,
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}