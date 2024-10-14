import 'package:mapesa/src/types.dart';

enum SingleUploadStatusType {
  success,
  clientSideError,
  serverSideError,
  nothingToUpload,
  unknown,
}

class SinglePayloadUploadResponse {
  SingleUploadStatusType status;
  String? message;
  ListOfObjects oks;
  ListOfObjects failed;
  ListOfObjects duplicates;

  SinglePayloadUploadResponse(
      {this.status = SingleUploadStatusType.unknown,
      this.message,
      this.oks = const [],
      this.failed = const [],
      this.duplicates = const []});

  @override
  String toString() {
    return 'SinglePayloadUploadResponse{ oks: $oks, status: $status, failed: $failed, duplicates: $duplicates}';
  }
}

enum BatchUploadStatusType { success, partial, fail, nothingToUpload }

class BatchUpload {
  BatchUploadStatusType status;
  String? message;
  ListOfObjects oks;
  ListOfObjects failed;
  ListOfObjects duplicates;

  BatchUpload(
      {this.status = BatchUploadStatusType.success,
      this.oks = const [],
      this.failed = const [],
      this.duplicates = const []});

  @override
  String toString() {
    return 'BatchUpload{status: $status, message: $message, failed: $failed, duplicates: $duplicates}';
  }
}

typedef UploadResponseType = Future<(SingleUploadStatusType, bool)>;
