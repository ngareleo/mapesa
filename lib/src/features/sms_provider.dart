import 'dart:isolate';
import 'package:permission_handler/permission_handler.dart';
import 'package:telephony/telephony.dart';

// module for reading sms\

class SMSProvider {
  // Modules will request SmsMessages from this class
  static SMSProvider? _instance;
  static final telephony = Telephony.instance;
  final maxMessages = 100000;

  SMSProvider._() {
    _instance = this;
  }

  static SMSProvider get instance => _instance ?? SMSProvider._();

  Future<void> _checkPermission() async {
    var permission = await Permission.sms.status;
    if (!permission.isGranted) {
      await Permission.sms.request();
    }
  }

  Future<List<SmsMessage>> fetchRecentMessages({int fromId = 0}) async {
    await _checkPermission();
    var messages = await telephony.getInboxSms(
        columns: [SmsColumn.ADDRESS, SmsColumn.BODY, SmsColumn.ID],
        filter: SmsFilter.where(SmsColumn.ADDRESS).equals("MPESA"));
    return messages;
  }

  Future<(int, int)> _findSmsRange() async {
    /// Looks for the first and last ids from db
    /// Low Perf executed as little as possible
    ///
    // TODO: Persist this value and to reuse during next compute

    await _checkPermission();
    var messages = await Isolate.run(() => telephony.getInboxSms(
        columns: [SmsColumn.ID, SmsColumn.ADDRESS, SmsColumn.BODY],
        filter: SmsFilter.where(SmsColumn.ADDRESS).equals("MPESA"),
        sortOrder: [
          OrderBy(SmsColumn.ID, sort: Sort.DESC),
        ]));
    return (messages.first.id ?? 0, messages.first.id ?? 0);
  }
}
