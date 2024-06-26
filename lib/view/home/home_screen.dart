import 'package:chatapp_ksn/app/widget/app_text.dart';
import 'package:chatapp_ksn/constant/app_colors.dart';
import 'package:chatapp_ksn/controller/home/home_controller.dart';
import 'package:chatapp_ksn/routes/route_helper.dart';
import 'package:chatapp_ksn/services/share_preference.dart';
import 'package:chatapp_ksn/utils/responsive.dart';
import 'package:chatapp_ksn/view/home/chat_area.dart';
import 'package:chatapp_ksn/view/home/chat_screen.dart';
import 'package:chatapp_ksn/view/home/widget/user_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isExtraSmallDevice = Responsive.isExtraSmall(context);
    bool isSmallDevice = Responsive.isSmall(context);

    return GetBuilder<HomeController>(
        init: HomeController(),
        initState: (state) {
          HomeController controller = Get.put(HomeController());

          controller.connectWebSocket();
        },
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: InkWell(
                      onTap: () {
                        SharedPrefService.instance.clearPreferenceData();
                        Get.offAllNamed(RouteHelper.getSigninRoute());
                      },
                      child: const Icon(Icons.logout_rounded)),
                ),
              ],
            ),
            body: Container(
              height: double.infinity,
              width: double.infinity,
              child: Row(
                children: [
                  Container(
                    height: double.infinity,
                    width: isExtraSmallDevice || isSmallDevice ? 100.w : 30.w,
                    padding: const EdgeInsets.only(top: 10),
                    color: AppColorConstant.appWhite,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Obx(() => ListView.separated(
                                itemCount: controller.usersList.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      controller.selectedUserEmail.value =
                                          controller.usersList[index].email ??
                                              "";
                                      controller.selectedUserIndex.value =
                                          index;
                                      print("printng in ontap");
                                      controller.loadMessages();

                                      if (isExtraSmallDevice || isSmallDevice) {
                                        Get.toNamed(
                                            "${RouteHelper.getChatRoute()}/${controller.usersList[controller.selectedUserIndex.value].username}");
                                      }
                                    },
                                    child: UserCard(
                                      index: index,
                                      email:
                                          controller.usersList[index].email ??
                                              "",
                                      username: controller
                                              .usersList[index].username ??
                                          "",
                                    ),
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 10,
                                  );
                                },
                              )),
                        ),
                      ],
                    ),
                  ),
                  if (!isExtraSmallDevice && !isSmallDevice)
                    Expanded(
                      child: Container(
                        height: double.infinity,
                        // width: 60.w,
                        color: Colors.grey[100],
                        child: ChatArea(),
                      ),
                    )
                ],
              ),
            ),
          );
        });
  }
}
