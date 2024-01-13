enum Operation { ok, fail }

abstract class CacheItem<T> {
  T value;
  final String key;
  final DateTime? expiry;

  CacheItem({required this.key, required this.value, this.expiry});

  Future<Operation> write(T value);
  Future<T?> read();
}

class MessageLimit {
  final int start;
  final int end;

  MessageLimit(this.start, this.end) {
    assert(start <= end);
  }
}

class BackendURLCacheItem extends CacheItem<String> {
  BackendURLCacheItem({required super.key, required super.value});

  @override
  Future<Operation> write(String value) async {
    throw UnimplementedError();
  }

  @override
  Future<String?> read() async {
    throw UnimplementedError();
  }
}
