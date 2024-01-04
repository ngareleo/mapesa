import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:permission_handler/permission_handler.dart';

class MessageHandler {
  final SmsQuery _query = SmsQuery();
  static const maxMessages = 100000;

  Future<List<SmsMessage>> fetchMessages({int latestID = 0}) async {
    var permission = await Permission.sms.status;
    if (permission.isGranted) {
      return (latestID == 0)
          ? await initializeAllTransactions()
          : await initializeRecentTransactions(from: latestID);
    }
    await Permission.sms.request();
    return [];
  }

  Future<List<SmsMessage>> initializeAllTransactions() async {
    return await _query.querySms(
        kinds: [SmsQueryKind.inbox],
        address: "MPESA",
        count: maxMessages,
        start: 0,
        sort: true);
  }

  Future<List<SmsMessage>> initializeRecentTransactions(
      {required int from}) async {
    var count = 0;
    List<SmsMessage> messages = [];
    do {
      List<SmsMessage> pool = await _query.querySms(
          kinds: [SmsQueryKind.inbox],
          address: "MPESA",
          count: 1,
          start: count++,
          sort: true);
      var message = pool.elementAt(0);
      if (message.id! <= from) {
        return messages;
      }
      messages.add(message);
    } while (count < maxMessages);
    return messages;
  }
}
