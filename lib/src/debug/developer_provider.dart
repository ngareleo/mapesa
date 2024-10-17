import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flagsmith/flagsmith.dart';
import 'package:isar/isar.dart';

import 'package:mapesa/src/features/feature_flags_provider.dart';
import 'package:mapesa/src/features/shared_preferences_keystore.dart';
import 'package:mapesa/src/models/compact_transaction.dart';

class DeveloperProvider {
  // Handles developer dependencies

  static final FlagsmithClient _flagsmith = FeatureFlagsProvider.client;
  static DeveloperProvider? _instance;
  final Isar _isar;

  static void init(isar) {
    if (_instance != null) {
      throw Exception("DeveloperProvider already initialized");
    }
    _instance = DeveloperProvider._(isar);
  }

  static DeveloperProvider get instance {
    if (_instance == null) {
      throw Exception("DeveloperProvider not initialized");
    }
    return _instance!;
  }

  DeveloperProvider._(this._isar);

  Future<void> resetApp() async {
    // reset shared preferences
    final prefs = await SharedPreferences.getInstance();
    final keys = SharedPreferencesKeyStore.values.map((k) => k.value).toList();
    for (final key in keys) {
      await prefs.remove(key);
    }

    // reset the local database
    await _isar.writeTxn(() async {
      await _isar.compactTransactions.where().deleteAll();
    });
  }
}
