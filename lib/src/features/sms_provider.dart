import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:telephony/telephony.dart';

import 'package:mapesa/src/features/cache/cache_items.dart';
import 'package:mapesa/src/features/cache/common_cache.dart';

class SMSProvider {
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

  Future<List<SmsMessage>> fetchAllTransactions() async {
    await _checkPermission();
    var messages = await telephony.getInboxSms(
        columns: [SmsColumn.ADDRESS, SmsColumn.BODY],
        filter: SmsFilter.where(SmsColumn.ADDRESS).equals("MPESA"));
    return messages;
  }

  Future<(int, int)> findSmsRange() async {
    /// Looks for the first and last ids
    /// Low Perf

    await _checkPermission();
    var messages = await telephony.getInboxSms(
        columns: [SmsColumn.ID, SmsColumn.ADDRESS, SmsColumn.BODY],
        filter: SmsFilter.where(SmsColumn.ADDRESS).equals("MPESA"),
        sortOrder: [
          OrderBy(SmsColumn.ID, sort: Sort.DESC),
        ]);
    return (messages.first.id ?? 0, messages.first.id ?? 0);
  }

  Future<void> updateMessageLimit() async {
    await _checkPermission();
    var (start, end) = await findSmsRange();
    var prefs = await SharedPreferences.getInstance();
    CommonCache.messageLimitCache.write(prefs, MessageLimit(start, end));
  }
}
