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

  static Future<void> init() async {}

  SMSProvider._() {
    _instance = this;
  }

  Future<PermissionStatus> _requestPermission() async {
    var permission = await Permission.sms.status;
    return permission.isGranted
        ? PermissionStatus.granted
        : await Permission.sms.request();
  }

  ///
  ///Fetch Sms messages
  ///
  Future<ManySms> fetchMessages({int? fromId, int? max = maxMessages}) async {
    final permission = await _requestPermission();

    if (permission == PermissionStatus.denied) {
      throw Exception("Permission denied");
    }

    var messages = fromId == null
        ? await firstFreshFetch()
        : await telephony.getInboxSms(
            columns: [SmsColumn.ADDRESS, SmsColumn.BODY, SmsColumn.ID],
            filter: SmsFilter.where(SmsColumn.ADDRESS)
                .equals("MPESA")
                .and(SmsColumn.ID)
                .greaterThan(fromId.toString()));

    if (messages.length > maxMessages) {
      messages = messages.sublist(0, maxMessages);
    }

    return messages;
  }

  ///
  /// Carefully fetches messages until max.
  ///
  Future<ManySms> firstFreshFetch({int max = maxMessages}) async {
    // A needed measure due to limitation of the API
    // works on the assumption that no two messages in the entire inbox have similar ids
    final permission = await _requestPermission();
    if (permission == PermissionStatus.denied) {
      return [];
    }
    var messages = <SmsMessage>[];
    var leftMarker = 0;
    var estimateQueryConstraint =
        max; // A query constraint to avoid accidentally flooding excess messages and hanging the UI
    var missed = false;
    while (messages.length < max) {
      final batch = await telephony.getInboxSms(
          columns: [SmsColumn.ADDRESS, SmsColumn.BODY, SmsColumn.ID],
          filter: SmsFilter.where(SmsColumn.ADDRESS)
              .equals("MPESA")
              .and(SmsColumn.ID)
              .greaterThan(leftMarker.toString())
              .and(SmsColumn.ID)
              .lessThan(estimateQueryConstraint.toString()));
      messages.addAll(batch);

      if (batch.isEmpty) {
        if (missed) {
          // if we do consecutive queries without results we quit
          break;
        }
        missed = true;
      } else {
        if (missed) {
          // false alarm, maybe there was a gap or something else
          missed = false;
        }
      }

      if (messages.length < max) {
        leftMarker = estimateQueryConstraint; // sliding window kind of
        estimateQueryConstraint += missed
            ? 3000 // if we missed we raise to constraint to see if we can reach further
            : 1000; // keep raising the constraint until we hit the limit
      }
    }

    if (messages.length > max) {
      messages = messages.sublist(0, maxMessages);
    }

    return messages;
  }

  ///
  /// Looks for the first and last ids from db
  /// Low Perf executed as little as possible
  ///
  Future<(int, int)> _findSmsRange() async {
    final permission = await _requestPermission();
    if (permission == PermissionStatus.denied) {
      return (0, 0);
    }
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
