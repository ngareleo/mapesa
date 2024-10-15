import 'dart:isolate';
import 'package:permission_handler/permission_handler.dart';
import 'package:telephony/telephony.dart';

typedef ManySms = List<SmsMessage>;

// module for reading sms messages
class SMSProvider {
  // Modules will request SmsMessages from this class
  // This provider doesn't need to be initialized using init()

  static SMSProvider? _instance;
  static const maxMessages = 1000;
  final telephony = Telephony.instance;
  static SMSProvider get instance => _instance ?? SMSProvider._();

  SMSProvider._() {
    _instance = this;
  }

  Future<void> _checkPermission() async {
    var permission = await Permission.sms.status;
    if (!permission.isGranted) {
      await Permission.sms.request();
    }
  }

  Future<ManySms> fetchRecentMessages({int fromId = 0}) async {
    await _checkPermission();
    var messages = await telephony.getInboxSms(
      columns: [SmsColumn.ADDRESS, SmsColumn.BODY, SmsColumn.ID],
      filter: SmsFilter.where(SmsColumn.ADDRESS)
          .equals("MPESA")
          .and(SmsColumn.ID)
          .greaterThan(fromId.toString()),
    );

    if (messages.length > maxMessages) {
      messages = messages.sublist(0, maxMessages);
    }

    return messages;
  }

  Future<(int, int)> _findSmsRange() async {
    /// Looks for the first and last ids from db
    /// Low Perf executed as little as possible
    await _checkPermission();
    var messages = await Isolate.run(() => telephony.getInboxSms(
        columns: [
          SmsColumn.ID,
          SmsColumn.ADDRESS,
          SmsColumn.BODY,
          SmsColumn.DATE
        ],
        filter: SmsFilter.where(SmsColumn.ADDRESS).equals("MPESA"),
        sortOrder: [
          OrderBy(SmsColumn.ID, sort: Sort.DESC),
        ]));
    return (messages.first.id ?? 0, messages.first.id ?? 0);
  }

  void nullCheck() {
    assert(_instance != null, true);
  }
}
