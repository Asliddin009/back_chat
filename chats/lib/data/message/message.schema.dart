// ignore_for_file: annotate_overrides

part of 'message.dart';

extension MessageRepositories on Database {
  MessageRepository get messages => MessageRepository._(this);
}

abstract class MessageRepository
    implements
        ModelRepository,
        KeyedModelRepositoryInsert<MessageInsertRequest>,
        ModelRepositoryUpdate<MessageUpdateRequest>,
        ModelRepositoryDelete<int> {
  factory MessageRepository._(Database db) = _MessageRepository;

  Future<MessageView?> queryMessage(int id);
  Future<List<MessageView>> queryMessages([QueryParams? params]);
}

class _MessageRepository extends BaseRepository
    with
        KeyedRepositoryInsertMixin<MessageInsertRequest>,
        RepositoryUpdateMixin<MessageUpdateRequest>,
        RepositoryDeleteMixin<int>
    implements MessageRepository {
  _MessageRepository(super.db) : super(tableName: 'messages', keyName: 'id');

  @override
  Future<MessageView?> queryMessage(int id) {
    return queryOne(id, MessageViewQueryable());
  }

  @override
  Future<List<MessageView>> queryMessages([QueryParams? params]) {
    return queryMany(MessageViewQueryable(), params);
  }

  @override
  Future<List<int>> insert(List<MessageInsertRequest> requests) async {
    if (requests.isEmpty) return [];
    var values = QueryValues();
    var rows = await db.query(
      'INSERT INTO "messages" ( "body", "author_id", "chat_id" )\n'
      'VALUES ${requests.map((r) => '( ${values.add(r.body)}:text, ${values.add(r.authorId)}:text, ${values.add(r.chatId)}:int8 )').join(', ')}\n'
      'RETURNING "id"',
      values.values,
    );
    var result = rows.map<int>((r) => TextEncoder.i.decode(r.toColumnMap()['id'])).toList();

    return result;
  }

  @override
  Future<void> update(List<MessageUpdateRequest> requests) async {
    if (requests.isEmpty) return;
    var values = QueryValues();
    await db.query(
      'UPDATE "messages"\n'
      'SET "body" = COALESCE(UPDATED."body", "messages"."body"), "author_id" = COALESCE(UPDATED."author_id", "messages"."author_id"), "chat_id" = COALESCE(UPDATED."chat_id", "messages"."chat_id")\n'
      'FROM ( VALUES ${requests.map((r) => '( ${values.add(r.id)}:int8::int8, ${values.add(r.body)}:text::text, ${values.add(r.authorId)}:text::text, ${values.add(r.chatId)}:int8::int8 )').join(', ')} )\n'
      'AS UPDATED("id", "body", "author_id", "chat_id")\n'
      'WHERE "messages"."id" = UPDATED."id"',
      values.values,
    );
  }
}

class MessageInsertRequest {
  MessageInsertRequest({
    required this.body,
    required this.authorId,
    this.chatId,
  });

  final String body;
  final String authorId;
  final int? chatId;
}

class MessageUpdateRequest {
  MessageUpdateRequest({
    required this.id,
    this.body,
    this.authorId,
    this.chatId,
  });

  final int id;
  final String? body;
  final String? authorId;
  final int? chatId;
}

class MessageViewQueryable extends KeyedViewQueryable<MessageView, int> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(int key) => TextEncoder.i.encode(key);

  @override
  String get query => 'SELECT "messages".*'
      'FROM "messages"';

  @override
  String get tableAlias => 'messages';

  @override
  MessageView decode(TypedMap map) =>
      MessageView(id: map.get('id'), body: map.get('body'), authorId: map.get('author_id'));
}

class MessageView {
  MessageView({
    required this.id,
    required this.body,
    required this.authorId,
  });

  final int id;
  final String body;
  final String authorId;
}
