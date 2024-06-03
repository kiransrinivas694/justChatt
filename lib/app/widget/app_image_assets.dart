// ignore_for_file: deprecated_member_use

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppImageAsset extends StatelessWidget {
  final String? image;
  final double? height;
  final double? width;
  final Color? color;
  final BoxFit? fit;
  final bool isFile;

  const AppImageAsset({
    Key? key,
    @required this.image,
    this.fit,
    this.height,
    this.width,
    this.color,
    this.isFile = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (image == null || image!.isEmpty || image!.contains('http'))
        ? Image.network(
            "$image",
            fit: fit ?? BoxFit.cover,
            color: color,
            height: height,
            width: width,
          )
        : isFile
            ? Image.file(File(image ?? ''),
                height: height, width: width, color: color, fit: fit)
            : image!.split('.').last != 'svg'
                ? Image.asset(image!,
                    fit: fit, height: height, width: width, color: color)
                : SvgPicture.asset(image!,
                    height: height, width: width, color: color);
  }
}
