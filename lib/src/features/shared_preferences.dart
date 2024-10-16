// Don't know a way to reset all the shared preferences
// Creating a key store that I'll instead use
enum SharedPreferencesKeyStore {
  authProvider(
      key: StoreKeys.authProvider, value: "simple_local_repo_last_message_id"),
  mobileServerReconciliation(
      key: StoreKeys.mobileServerReconciliation, value: "last_message_id");

  final StoreKeys key;
  final String value;

  const SharedPreferencesKeyStore({required this.key, required this.value});
}

enum StoreKeys { authProvider, mobileServerReconciliation }
