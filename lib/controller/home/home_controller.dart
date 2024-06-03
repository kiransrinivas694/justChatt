import 'dart:convert';

import 'package:chatapp_ksn/app/utils/app_utils.dart';
import 'package:chatapp_ksn/constant/app_strings.dart';
import 'package:chatapp_ksn/model/message_model.dart';
import 'package:chatapp_ksn/model/user_model.dart';
import 'package:chatapp_ksn/services/share_preference.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/html.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class HomeController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> onInit() async {
    connectWebSocket();
    loadMessages();
    getLoggedDetails();
    print("inti is called");
    super.onInit();
  }

  //Logged in user details;
  String loggedUsername = "";
  String loggedEmail = "";

  Future<void> getLoggedDetails() async {
    loggedUsername =
        await getSharedPreferenceValue(SharedPrefService.instance.username);

    loggedEmail =
        await getSharedPreferenceValue(SharedPrefService.instance.email);
  }

  // Users List
  List<UserModel> usersList = <UserModel>[].obs;
  final userListLoad = false.obs;

  void fetchUsers() async {
    QuerySnapshot querySnapshot = await _firestore.collection('users').get();

    print(
        "all users data -> ${querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList()}");
    List<Map<String, dynamic>> usersQueryList = querySnapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

    for (var i in usersQueryList) {
      usersList.add(userModelFromJson(jsonEncode(i)));
    }
  }

  //Chat Area Messages
  final selectedUserIndex = 0.obs;
  final selectedUserEmail = "".obs;
  final TextEditingController messageController = TextEditingController();
  WebSocketChannel? _channel;
  final _isConnected = false.obs;
  final messagesList = <MessageModel>[].obs;
  final messageListLoad = false.obs;

  @override
  void dispose() {
    _channel!.sink.close();
    print("printing dispose is called");
    super.dispose();
  }

  void connectWebSocket() async {
    if (_channel != null) {
      return;
    }
    print("printing before socket connection");

    print('printing isConnected -> $_isConnected');
    // if (_isConnected.value) {
    //   return;
    // }

    _channel = HtmlWebSocketChannel.connect(Uri.parse(
        'wss://demo.piesocket.com/v3/channel_123?api_key=JHN4ey9kkC5nZq5qIfZdyd1K3sa2mVwVZjKYMeN2'));
    print(
      "printing after socket connection",
    );
    _isConnected.value = true;
    _channel!.stream.listen((message) {
      print("printing listening messages -> $message");

      Map<String, dynamic> messageResponse = jsonDecode(message);

      // //  if ()
      // print(
      //     "printing listening messages after decode -> ${messageResponse["senderName"]}");
      // print(
      //     "printing listening messages after decode -> ${messageResponse["senderMail"]}");

      // print(
      //     "printing listening messages after decode -> ${messageResponse["receiverName"]}");
      // print(
      //     "printing listening messages after decode -> ${messageResponse["receverId"]}");
      // print(
      //     "printing listening messages after decode -> ${messageResponse["messageContent"]}");
      // print(
      //     "printing listening messages after decode -> ${messageResponse["messageSendTime"]}");
      Box<MessageModel> messageBox =
          Hive.box<MessageModel>(AppStrings.messages);
      messageBox.add(
        MessageModel(
          messageResponse["senderName"],
          messageResponse["senderMail"],
          messageResponse["receiverName"],
          messageResponse["receverId"],
          messageResponse["messageContent"],
          DateTime.now(),
        ),
      );

      // print(
      //     "printing listening messages after decode -> ${messageResponse["messageSendTime"]}");

      // messageBoxadd(
      //   MessageModel(
      //     "kiran",
      //     "kiran@gmail.com",
      //     "sandeep",
      //     "sandeep@gmail.com",
      //     messageResponse["messageContent"],
      //     DateTime.now(),
      //   ),
      // );
      updateMessages();
    });
  }

  Future<void> loadMessages() async {
    Box<MessageModel> messageBox = Hive.box<MessageModel>(AppStrings.messages);
    messagesList.value = messageBox.values.toList(); //get all items in list
  }

  Future<void> updateMessages() async {
    Box<MessageModel> messageBox = Hive.box<MessageModel>(AppStrings.messages);
    messagesList.value = messageBox.values.toList();
    print("update message called - ${messagesList.length}");
    update();
  }

  void sendMessage() async {
    final String username =
        await getSharedPreferenceValue(SharedPrefService.instance.username);

    final String userEmail =
        await getSharedPreferenceValue(SharedPrefService.instance.email);

    print('sendmessage called');
    if (messageController.text.isNotEmpty) {
      final messageBody = {
        'senderName': username,
        'senderMail': userEmail,
        'receiverName': "sandeep",
        "receverId": "sandeep@gmail.co",
        'messageContent': messageController.text,
        'messageSendTime': DateTime.now().toIso8601String(),
      };

      // print("priting messages body-> $messageBody");
      _channel!.sink.add(jsonEncode(messageBody));

      // _channel!.sink.add("${messageController.text}");

      Box<MessageModel> messageBox =
          Hive.box<MessageModel>(AppStrings.messages);
      messageBox.add(
        MessageModel(
          username,
          userEmail,
          "sandeep",
          "sandeep@gmail.co",
          messageController.text,
          DateTime.now(),
        ),
      );

      updateMessages();

      // print("printing message boxvalue -> ${messageBox.values}");

      messageController.clear();
    }
  }
}
