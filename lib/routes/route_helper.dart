import 'package:chatapp_ksn/view/auth/signin/signin_screen.dart';
import 'package:chatapp_ksn/view/auth/signup/signup_screen.dart';
import 'package:chatapp_ksn/view/home/home_screen.dart';
import 'package:get/get.dart';
import 'route_constant.dart';

class RouteHelper {
  static String getSigninRoute() => RouteConstant.signin;
  static String getSignupRoute() => RouteConstant.signUp;
  static String getHomeRoute() => RouteConstant.home;

  static List<GetPage> routes = [
    GetPage(name: RouteConstant.signin, page: () => const SignInScreen()),
    GetPage(name: RouteConstant.signUp, page: () => const SignUpScreen()),
    GetPage(name: RouteConstant.home, page: () => const HomeScreen()),
  ];
}
