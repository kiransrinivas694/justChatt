import 'package:flutter/material.dart';

class Responsive {
  static bool isExtraSmall(BuildContext context) =>
      MediaQuery.of(context).size.width < 480;

  static bool isSmall(BuildContext context) =>
      MediaQuery.of(context).size.width < 768 &&
      MediaQuery.of(context).size.width >= 480;

  static bool isMedium(BuildContext context) =>
      MediaQuery.of(context).size.width < 1024 &&
      MediaQuery.of(context).size.width >= 768;

  static bool isLarge(BuildContext context) =>
      MediaQuery.of(context).size.width < 1280 &&
      MediaQuery.of(context).size.width >= 1024;
}
