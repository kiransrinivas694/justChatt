import 'package:chatapp_ksn/app/widget/app_image_assets.dart';
import 'package:chatapp_ksn/app/widget/app_text.dart';
import 'package:chatapp_ksn/app/widget/app_text_form_field.dart';
import 'package:chatapp_ksn/constant/app_asset.dart';
import 'package:chatapp_ksn/constant/app_colors.dart';
import 'package:chatapp_ksn/controller/auth/signin_controller.dart';
import 'package:chatapp_ksn/routes/route_helper.dart';
import 'package:chatapp_ksn/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isExtraSmallDevice = Responsive.isExtraSmall(context);
    bool isSmallDevice = Responsive.isSmall(context);

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
                  Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                              color: Color.fromRGBO(0, 0, 0, 0.15),
                              spreadRadius: 2,
                              blurRadius: 2,
                              offset: Offset(0, 1)),
                        ],
                        color: AppColorConstant.appWhite,
                        borderRadius: BorderRadius.circular(10)),
                    width: isExtraSmallDevice || isSmallDevice
                        ? double.infinity
                        : 40.w,
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
                            textEditingController: controller.emailController),
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
                        InkWell(
                          onTap: () {
                            controller.verifySignIn();
                          },
                          child: Container(
                            width: double.infinity,
                            color: AppColorConstant.blue1,
                            padding: const EdgeInsets.symmetric(vertical: 10),
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
                          child: InkWell(
                            onTap: () {
                              Get.offAllNamed(RouteHelper.getSignupRoute());
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
            ),
          );
        });
  }
}
