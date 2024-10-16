import 'package:flagsmith/flagsmith.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Flags {
  static const NEW_MAPESA_M1 = "new_mapesa_m1";
}

class FeatureFlagsProvider {
  static FlagsmithClient? _client;

  static FlagsmithClient get client {
    if (_client == null) {
      throw Exception("FeatureFlagsProvider not initialized");
    }
    return _client!;
  }

  static Future<void> init() async {
    if (_client != null) {
      throw Exception("FeatureFlagsProvider already exists");
    }

    _client = await FlagsmithClient.init(
      apiKey: dotenv.env["FLAGSMITH_API_KEY"] ?? "",
      config: const FlagsmithConfig(
        connectTimeout: 5000,
        receiveTimeout: 5000,
        sendTimeout: 5000,
        caches: true,
      ),
    );

    try {
      await _client?.initialize();
      await _client?.getFeatureFlags(reload: true);
    } catch (e) {
      debugPrint("Error getting feature flags $e");
      //noop
      // temporary fix for this known issue https://github.com/Flagsmith/flagsmith-flutter-client/issues/45
    }
  }

  FeatureFlagsProvider._();
}
