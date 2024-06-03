import 'package:chatapp_ksn/app/utils/app_utils.dart';
import 'package:chatapp_ksn/app/widget/app_text.dart';
import 'package:chatapp_ksn/app/widget/app_text_form_field.dart';
import 'package:chatapp_ksn/controller/home/home_controller.dart';
import 'package:chatapp_ksn/services/share_preference.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChatArea extends StatelessWidget {
  const ChatArea({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Column(
            children: [
              Expanded(
                child: Container(
                  height: 100,
                  width: double.infinity,
                  color: Colors.grey[100],
                  child: Obx(() => ListView.separated(
                        itemCount: controller.messagesList.length,
                        shrinkWrap: true,
                        reverse: true,
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: 10,
                          );
                        },
                        itemBuilder: (context, index) {
                          return Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(bottom: 10),
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Column(
                              crossAxisAlignment: controller.loggedEmail ==
                                      controller.messagesList[index].senderName
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.end,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.blue[100],
                                      borderRadius: BorderRadius.circular(10)),
                                  constraints: BoxConstraints(maxWidth: 35.w),
                                  child: Column(
                                    crossAxisAlignment:
                                        controller.loggedEmail ==
                                                controller.messagesList[index]
                                                    .senderName
                                            ? CrossAxisAlignment.end
                                            : CrossAxisAlignment.end,
                                    children: [
                                      AppText(
                                        controller
                                            .messagesList[index].messageContent,
                                      ),
                                      AppText(
                                        controller
                                            .messagesList[index].messageSendTime
                                            .toIso8601String(),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      )),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: AppTextFormField(
                  hintText: "Send Message",
                  onSuffixTap: controller.sendMessage,
                  textEditingController: controller.messageController,
                  suffixIcon: const Icon(Icons.send),
                ),
              )
            ],
          );
        });
  }
}
