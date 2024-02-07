import 'dart:async';
import 'dart:typed_data';

import 'package:files/domain/i_storage.dart';
import 'package:files/generated/files.pbgrpc.dart';
import 'package:files/utils.dart';
import 'package:grpc/grpc.dart';

final class FilesRpc extends FilesRpcServiceBase {
  final IStorage storage;
  static const String _avatarsBucket = 'avatars';

  FilesRpc(this.storage);
  @override
  Future<ResponseDto> deleteAvatar(ServiceCall call, FileDto request) async {
    try {
      final id = Utils.getIdFromMetadata(call);
      await storage.deleteFile(bucket: _avatarsBucket, name: id.toString());
      return ResponseDto(isComplete: true, message: "Аватар удален");
    } on Exception catch (error) {
      throw GrpcError.internal("deleteAvatar не работает. Ошибка:$error");
    }
  }

  @override
  Future<ResponseDto> deleteFile(ServiceCall call, FileDto request) async {
    _checkInput(request);
    try {
      final message =
          await storage.deleteFile(bucket: request.bucket, name: request.name);
      return ResponseDto(
        message: message,
        isComplete: true,
      );
    } on Exception catch (error) {
      throw GrpcError.internal("deleteFile не работает. Ошибка:$error");
    }
  }

  @override
  Future<FileDto> fetchAvatar(ServiceCall call, FileDto request) async {
    try {
      final id = Utils.getIdFromMetadata(call);
      final list = <int>[];
      final stream =
          storage.fetchFile(bucket: _avatarsBucket, name: id.toString());
      final streamData = await stream.toList();
      for (var element in streamData) {
        list.addAll(element);
      }
      return FileDto(data: Uint8List.fromList(list));
    } on Exception catch (error) {
      throw GrpcError.internal("fetchAvatar не работает. Ошибка:$error");
    }
  }

  @override
  Future<ResponseDto> putAvatar(ServiceCall call, FileDto request) async {
    if (request.data.isEmpty) {
      throw GrpcError.invalidArgument("data не найден");
    }
    if (request.data.length > 1000000) {
      throw GrpcError.invalidArgument('Аватар больше 1 мб');
    }
    try {
      final id = Utils.getIdFromMetadata(call);
      final tag = await storage.putFile(
          bucket: _avatarsBucket,
          name: id.toString(),
          data: request.data as Uint8List);
      return ResponseDto(
          isComplete: true, message: "Аватар успешно загружен", tag: tag);
    } on Exception catch (error) {
      throw GrpcError.internal("putAvatar не работает. Ошибка:$error");
    }
  }

  @override
  Future<ResponseDto> putFile(ServiceCall call, FileDto request) async {
    _checkInput(request);
    if (request.data.isEmpty) {
      throw GrpcError.invalidArgument("data не найден");
    }
    try {
      final tag = await storage.putFile(
          bucket: request.bucket,
          name: request.name,
          data: request.data as Uint8List);
      return ResponseDto(message: "Успешно", isComplete: true, tag: tag);
    } catch (error) {
      throw GrpcError.internal("PutFile не работает. Ошибка:$error");
    }
  }

  void _checkInput(FileDto request) {
    if (request.bucket.isEmpty) {
      throw GrpcError.invalidArgument("bucket не найден");
    }
    if (request.name.isEmpty) {
      throw GrpcError.invalidArgument("name не найден");
    }
  }

  @override
  Stream<FileDto> fetchFile(ServiceCall call, FileDto request) async* {
    _checkInput(request);
    try {
      yield* storage
          .fetchFile(bucket: request.bucket, name: request.name)
          .transform(StreamTransformer.fromHandlers(
        handleData: (data, sink) {
          final arr = Uint8List.fromList(data);
          sink.add(FileDto(data: arr));
        },
      ));
    } on Exception catch (error) {
      throw GrpcError.internal("fetchFile не работает. Ошибка:$error");
    }
  }
}
