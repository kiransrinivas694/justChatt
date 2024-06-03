import 'package:chatapp_ksn/app/widget/app_text.dart';
import 'package:chatapp_ksn/constant/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class UserCard extends StatelessWidget {
  const UserCard(
      {super.key,
      required this.username,
      required this.email,
      required this.index});

  final String username;
  final String email;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: index == 2 ? Color.fromARGB(72, 94, 194, 240) : Colors.white,
          borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            username,
            color: AppColorConstant.appBlack,
            fontWeight: FontWeight.w600,
            fontSize: 18,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          AppText(
            email,
            color: AppColorConstant.appBlack,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
