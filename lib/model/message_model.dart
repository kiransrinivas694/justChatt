import 'package:hive/hive.dart';
part 'message_model.g.dart';

@HiveType(typeId: 0)
class MessageModel {
  @HiveField(0)
  final String senderName;

  @HiveField(1)
  final String senderMail;

  @HiveField(2)
  final String receiverName;

  @HiveField(3)
  final String recceiverMail;

  @HiveField(4)
  final String messageContent;

  @HiveField(5)
  final DateTime messageSendTime;

  const MessageModel(this.senderName, this.senderMail, this.receiverName,
      this.recceiverMail, this.messageContent, this.messageSendTime);
}
