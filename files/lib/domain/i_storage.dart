import 'dart:typed_data';

abstract interface class IStorage {
  Future<String> putFile(
      {required String bucket, required String name, required Uint8List data});

  Future<String> deleteFile({required String bucket, required String name});

  Stream<List<int>> fetchFile({required String bucket, required String name});
}
