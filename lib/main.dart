import 'dart:convert';

import 'package:chatapp_ksn/constant/app_strings.dart';
import 'package:chatapp_ksn/login.dart';
import 'package:chatapp_ksn/model/message_model.dart';
import 'package:chatapp_ksn/routes/route_helper.dart';
import 'package:chatapp_ksn/view/auth/signin/signin_screen.dart';
import 'package:chatapp_ksn/view/auth/signup/signup_screen.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MessageModelAdapter());

  await Hive.openBox<MessageModel>(AppStrings.messages);
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyDoKmkUb6uGUDzUhmQFxkjg2QrG0nDJ084",
          appId: "1:99716348754:web:38491f5ff2fb0c86db988b",
          messagingSenderId: "99716348754",
          projectId: "justchatt-72190"),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus!.unfocus(),
        child: ResponsiveSizer(builder: (context, orientation, screenType) {
          return GetMaterialApp(
            title: 'Just Chatt',
            navigatorKey: Get.key,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
            ),
            initialRoute: RouteHelper.getSigninRoute(),
            getPages: RouteHelper.routes,
            defaultTransition: Transition.fadeIn,
          );
        }),
      ),
    );
  }
}

// class ChatScreen extends StatefulWidget {
//   @override
//   _ChatScreenState createState() => _ChatScreenState();
// }

// class _ChatScreenState extends State<ChatScreen> {
//   final TextEditingController _controller = TextEditingController();
//   final List<String> _messages = [];
//   late WebSocketChannel _channel;
//   late SharedPreferences _prefs;

//   @override
//   void initState() {
//     super.initState();
//     // _initWebSocket();
//     _loadMessages();
//   }

//   // void _initWebSocket() async {
//   //   print("printing before socket connection");

//   //   _channel = HtmlWebSocketChannel.connect(Uri.parse(
//   //       'wss://demo.piesocket.com/v3/channel_123?api_key=JHN4ey9kkC5nZq5qIfZdyd1K3sa2mVwVZjKYMeN2'));
//   //   print("printing after socket connection");
//   //   _channel.stream.listen((message) {
//   //     print("printing listening messages -> $message");
//   //     // final decodedMessage = jsonDecode(message);
//   //     // print("printing listening messages -> $decodedMessage");
//   //     // if (decodedMessage['type'] == 'chat') {
//   //     setState(() {
//   //       _messages.add(message);
//   //       _saveMessages();
//   //     });
//   //     // } else {
//   //     // Handle other types of messages if needed
//   //     // }
//   //   });
//   // }

//   Future<void> _loadMessages() async {
//     _prefs = await SharedPreferences.getInstance();
//     final String? messagesString = _prefs.getString('messages');
//     if (messagesString != null) {
//       final List<String> messagesList = jsonDecode(messagesString);
//       setState(() {
//         _messages.addAll(messagesList);
//       });
//     }
//   }

//   Future<void> _saveMessages() async {
//     // final String messagesString = jsonEncode(_messages);
//     // await _prefs.setString('messages', "");
//   }

//   @override
//   void dispose() {
//     _channel.sink.close();
//     print("printing dispose is called");
//     super.dispose();
//   }

//   void _sendMessage() {
//     if (_controller.text.isNotEmpty) {
//       final message = {
//         'type': 'chat',
//         'text': _controller.text,
//         'sender': 'Me',
//         'timestamp': DateTime.now().toIso8601String(),
//       };
//       _channel.sink.add(jsonEncode(message));
//       setState(() {
//         _messages.add(_controller.text);
//       });
//       _controller.clear();
//       _saveMessages();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Flutter Chat'),
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView.builder(
//               padding: const EdgeInsets.all(8),
//               itemCount: _messages.length,
//               itemBuilder: (context, index) {
//                 final message = _messages[index];
//                 return ListTile(
//                   title: Text(message),
//                   // subtitle: Text(DateTime.parse(message['timestamp'])
//                   //     .toLocal()
//                   //     .toString()),
//                 );
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: _controller,
//                     decoration: InputDecoration(
//                       labelText: 'Send a message',
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: Icon(Icons.send),
//                   onPressed: _sendMessage,
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
