import 'package:flagsmith/flagsmith.dart';
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
        connectTimeout: 200,
        receiveTimeout: 500,
        sendTimeout: 500,
        caches: true,
      ),
      seeds: <Flag>[
        Flag.seed('feature', enabled: true),
      ],
    );

    await _client?.initialize();

    try {
      await _client?.getFeatureFlags(reload: true);
    } catch (e) {
      //noop
      // temporary fix for this known issue https://github.com/Flagsmith/flagsmith-flutter-client/issues/45
    }
  }

  FeatureFlagsProvider._();
}
