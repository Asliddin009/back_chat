// ignore_for_file: annotate_overrides

part of 'session.dart';

extension SessionRepositories on Database {
  SessionUserRepository get sessionUsers => SessionUserRepository._(this);
}

abstract class SessionUserRepository
    implements
        ModelRepository,
        KeyedModelRepositoryInsert<SessionUserInsertRequest>,
        ModelRepositoryUpdate<SessionUserUpdateRequest>,
        ModelRepositoryDelete<int> {
  factory SessionUserRepository._(Database db) = _SessionUserRepository;

  Future<SessionUserView?> querySessionUser(int id);
  Future<List<SessionUserView>> querySessionUsers([QueryParams? params]);
}

class _SessionUserRepository extends BaseRepository
    with
        KeyedRepositoryInsertMixin<SessionUserInsertRequest>,
        RepositoryUpdateMixin<SessionUserUpdateRequest>,
        RepositoryDeleteMixin<int>
    implements SessionUserRepository {
  _SessionUserRepository(super.db) : super(tableName: 'session_users', keyName: 'id');

  @override
  Future<SessionUserView?> querySessionUser(int id) {
    return queryOne(id, SessionUserViewQueryable());
  }

  @override
  Future<List<SessionUserView>> querySessionUsers([QueryParams? params]) {
    return queryMany(SessionUserViewQueryable(), params);
  }

  @override
  Future<List<int>> insert(List<SessionUserInsertRequest> requests) async {
    if (requests.isEmpty) return [];
    var values = QueryValues();
    var rows = await db.query(
      'INSERT INTO "session_users" ( "user_id", "list_token" )\n'
      'VALUES ${requests.map((r) => '( ${values.add(r.userId)}:int8, ${values.add(r.listToken)}:_text )').join(', ')}\n'
      'RETURNING "id"',
      values.values,
    );
    var result = rows.map<int>((r) => TextEncoder.i.decode(r.toColumnMap()['id'])).toList();

    return result;
  }

  @override
  Future<void> update(List<SessionUserUpdateRequest> requests) async {
    if (requests.isEmpty) return;
    var values = QueryValues();
    await db.query(
      'UPDATE "session_users"\n'
      'SET "user_id" = COALESCE(UPDATED."user_id", "session_users"."user_id"), "list_token" = COALESCE(UPDATED."list_token", "session_users"."list_token")\n'
      'FROM ( VALUES ${requests.map((r) => '( ${values.add(r.id)}:int8::int8, ${values.add(r.userId)}:int8::int8, ${values.add(r.listToken)}:_text::_text )').join(', ')} )\n'
      'AS UPDATED("id", "user_id", "list_token")\n'
      'WHERE "session_users"."id" = UPDATED."id"',
      values.values,
    );
  }
}

class SessionUserInsertRequest {
  SessionUserInsertRequest({
    required this.userId,
    required this.listToken,
  });

  final int userId;
  final List<String> listToken;
}

class SessionUserUpdateRequest {
  SessionUserUpdateRequest({
    required this.id,
    this.userId,
    this.listToken,
  });

  final int id;
  final int? userId;
  final List<String>? listToken;
}

class SessionUserViewQueryable extends KeyedViewQueryable<SessionUserView, int> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(int key) => TextEncoder.i.encode(key);

  @override
  String get query => 'SELECT "session_users".*, row_to_json("user".*) as "user"'
      'FROM "session_users"'
      'LEFT JOIN (${UserViewQueryable().query}) "user"'
      'ON "session_users"."user_id" = "user"."id"';

  @override
  String get tableAlias => 'session_users';

  @override
  SessionUserView decode(TypedMap map) => SessionUserView(
      id: map.get('id'),
      user: map.get('user', UserViewQueryable().decoder),
      listToken: map.getListOpt('list_token') ?? const []);
}

class SessionUserView {
  SessionUserView({
    required this.id,
    required this.user,
    required this.listToken,
  });

  final int id;
  final UserView user;
  final List<String> listToken;
}
