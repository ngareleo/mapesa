import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mapesa/src/features/cache/cache_items.dart';

class CommonCache {
  // A cache that is loaded with variables that are used across modules and UI

  static CommonCache? _instance;

  final _backendUrlCache = BackendURLCacheItem(
      key: "backend_url", value: dotenv.env["BACKEND_URL"] ?? "");

  factory CommonCache() {
    return CommonCache._();
  }

  CommonCache._() {
    _instance = this;
  }

  static CommonCache get instance => _instance ?? CommonCache._();
  static BackendURLCacheItem get backendURLCache => instance._backendUrlCache;
}
