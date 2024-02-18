// ignore_for_file: annotate_overrides

part of 'session.dart';

extension SessionRepositories on Database {
  SessionRepository get sessions => SessionRepository._(this);
}

abstract class SessionRepository
    implements
        ModelRepository,
        KeyedModelRepositoryInsert<SessionInsertRequest>,
        ModelRepositoryUpdate<SessionUpdateRequest>,
        ModelRepositoryDelete<int> {
  factory SessionRepository._(Database db) = _SessionRepository;

  Future<SessionView?> querySession(int id);
  Future<List<SessionView>> querySessions([QueryParams? params]);
}

class _SessionRepository extends BaseRepository
    with
        KeyedRepositoryInsertMixin<SessionInsertRequest>,
        RepositoryUpdateMixin<SessionUpdateRequest>,
        RepositoryDeleteMixin<int>
    implements SessionRepository {
  _SessionRepository(super.db) : super(tableName: 'sessions', keyName: 'id');

  @override
  Future<SessionView?> querySession(int id) {
    return queryOne(id, SessionViewQueryable());
  }

  @override
  Future<List<SessionView>> querySessions([QueryParams? params]) {
    return queryMany(SessionViewQueryable(), params);
  }

  @override
  Future<List<int>> insert(List<SessionInsertRequest> requests) async {
    if (requests.isEmpty) return [];
    var values = QueryValues();
    var rows = await db.query(
      'INSERT INTO "sessions" ( "user_id", "list_token" )\n'
      'VALUES ${requests.map((r) => '( ${values.add(r.userId)}:int8, ${values.add(r.listToken)}:_text )').join(', ')}\n'
      'RETURNING "id"',
      values.values,
    );
    var result = rows.map<int>((r) => TextEncoder.i.decode(r.toColumnMap()['id'])).toList();

    return result;
  }

  @override
  Future<void> update(List<SessionUpdateRequest> requests) async {
    if (requests.isEmpty) return;
    var values = QueryValues();
    await db.query(
      'UPDATE "sessions"\n'
      'SET "user_id" = COALESCE(UPDATED."user_id", "sessions"."user_id"), "list_token" = COALESCE(UPDATED."list_token", "sessions"."list_token")\n'
      'FROM ( VALUES ${requests.map((r) => '( ${values.add(r.id)}:int8::int8, ${values.add(r.userId)}:int8::int8, ${values.add(r.listToken)}:_text::_text )').join(', ')} )\n'
      'AS UPDATED("id", "user_id", "list_token")\n'
      'WHERE "sessions"."id" = UPDATED."id"',
      values.values,
    );
  }
}

class SessionInsertRequest {
  SessionInsertRequest({
    required this.userId,
    required this.listToken,
  });

  final int userId;
  final List<String> listToken;
}

class SessionUpdateRequest {
  SessionUpdateRequest({
    required this.id,
    this.userId,
    this.listToken,
  });

  final int id;
  final int? userId;
  final List<String>? listToken;
}

class SessionViewQueryable extends KeyedViewQueryable<SessionView, int> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(int key) => TextEncoder.i.encode(key);

  @override
  String get query => 'SELECT "sessions".*, row_to_json("user".*) as "user"'
      'FROM "sessions"'
      'LEFT JOIN (${UserViewQueryable().query}) "user"'
      'ON "sessions"."user_id" = "user"."id"';

  @override
  String get tableAlias => 'sessions';

  @override
  SessionView decode(TypedMap map) => SessionView(
      id: map.get('id'),
      user: map.get('user', UserViewQueryable().decoder),
      listToken: map.getListOpt('list_token') ?? const []);
}

class SessionView {
  SessionView({
    required this.id,
    required this.user,
    required this.listToken,
  });

  final int id;
  final UserView user;
  final List<String> listToken;
}
