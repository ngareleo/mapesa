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
  ListOfObjects failed;
  ListOfObjects duplicates;

  SinglePayloadUploadResponse(
      {this.status = SingleUploadStatusType.unknown,
      this.failed = const [],
      this.duplicates = const []});
}

enum BatchUploadStatusType { success, partial, fail, nothingToUpload }

class BatchUpload {
  BatchUploadStatusType status;
  String? message;
  ListOfObjects failed;
  ListOfObjects duplicates;

  BatchUpload(
      {this.status = BatchUploadStatusType.success,
      this.failed = const [],
      this.duplicates = const []});
}

typedef UploadResponseType = Future<(SingleUploadStatusType, bool)>;
