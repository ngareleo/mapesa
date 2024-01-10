import 'package:shared_preferences/shared_preferences.dart';

enum Operation { ok, fail }

abstract class CacheItem<T> {
  T value;
  final String key;
  final DateTime? expiry;

  CacheItem({required this.key, required this.value, this.expiry});

  Future<Operation> write(SharedPreferences pref, T value);
  Future<T?> read(SharedPreferences pref);
}

class MessageLimit {
  final int start;
  final int end;

  MessageLimit(this.start, this.end) {
    assert(start <= end);
  }
}

class MessageLimitCacheItem extends CacheItem<MessageLimit> {
  bool valid = false;

  MessageLimitCacheItem({required super.key, required super.value}) {
    onLoad();
  }

  void onLoad() async {
    final pref = await SharedPreferences.getInstance();
    var limit = await read(pref);
    if (limit != null && limit.start != 0 && limit.end != 0) {
      valid = true;
      value = limit;
    }
  }

  @override
  Future<Operation> write(SharedPreferences pref, MessageLimit value) async {
    this.value = value;
    valid = value.start != 0 && value.end != 0;

    await pref.setInt("start", value.start);
    await pref.setInt("end", value.end);
    return Operation.ok;
  }

  @override
  Future<MessageLimit?> read(SharedPreferences pref) async {
    final start = pref.getInt("start");
    final end = pref.getInt("end");
    if (start == null || end == null) {
      return null;
    }
    
    var messageLimit = MessageLimit(start, end);
    value = messageLimit;

    if (messageLimit.start == 0 && messageLimit.end == 0) {
      valid = false;
    }

    return messageLimit;
  }
}
