import 'package:mapesa/src/features/cache/cache_items.dart';

class CommonCache {
  // A cache that is loaded with variables that should be read
  static CommonCache? _instance;
  final _messageLimitCache = MessageLimitCacheItem(
    key: "message_limit",
    value: MessageLimit(0, 0),
  );

  factory CommonCache() {
    return CommonCache._();
  }

  CommonCache._() {
    _instance = this;
  }

  static CommonCache get instance => _instance ?? CommonCache._();
  static MessageLimitCacheItem get messageLimitCache =>
      instance._messageLimitCache;
}
