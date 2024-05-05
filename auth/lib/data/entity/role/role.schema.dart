// ignore_for_file: annotate_overrides

part of 'role.dart';

extension RoleRepositories on Database {
  RoleRepository get roles => RoleRepository._(this);
}

abstract class RoleRepository
    implements
        ModelRepository,
        KeyedModelRepositoryInsert<RoleInsertRequest>,
        ModelRepositoryUpdate<RoleUpdateRequest>,
        ModelRepositoryDelete<int> {
  factory RoleRepository._(Database db) = _RoleRepository;

  Future<RoleView?> queryRole(int id);
  Future<List<RoleView>> queryRoles([QueryParams? params]);
}

class _RoleRepository extends BaseRepository
    with
        KeyedRepositoryInsertMixin<RoleInsertRequest>,
        RepositoryUpdateMixin<RoleUpdateRequest>,
        RepositoryDeleteMixin<int>
    implements RoleRepository {
  _RoleRepository(super.db) : super(tableName: 'roles', keyName: 'id');

  @override
  Future<RoleView?> queryRole(int id) {
    return queryOne(id, RoleViewQueryable());
  }

  @override
  Future<List<RoleView>> queryRoles([QueryParams? params]) {
    return queryMany(RoleViewQueryable(), params);
  }

  @override
  Future<List<int>> insert(List<RoleInsertRequest> requests) async {
    if (requests.isEmpty) return [];
    var values = QueryValues();
    var rows = await db.query(
      'INSERT INTO "roles" ( "user_id", "role" )\n'
      'VALUES ${requests.map((r) => '( ${values.add(r.userId)}:int8, ${values.add(r.role)}:text )').join(', ')}\n'
      'RETURNING "id"',
      values.values,
    );
    var result = rows.map<int>((r) => TextEncoder.i.decode(r.toColumnMap()['id'])).toList();

    return result;
  }

  @override
  Future<void> update(List<RoleUpdateRequest> requests) async {
    if (requests.isEmpty) return;
    var values = QueryValues();
    await db.query(
      'UPDATE "roles"\n'
      'SET "user_id" = COALESCE(UPDATED."user_id", "roles"."user_id"), "role" = COALESCE(UPDATED."role", "roles"."role")\n'
      'FROM ( VALUES ${requests.map((r) => '( ${values.add(r.id)}:int8::int8, ${values.add(r.userId)}:int8::int8, ${values.add(r.role)}:text::text )').join(', ')} )\n'
      'AS UPDATED("id", "user_id", "role")\n'
      'WHERE "roles"."id" = UPDATED."id"',
      values.values,
    );
  }
}

class RoleInsertRequest {
  RoleInsertRequest({
    required this.userId,
    this.role,
  });

  final int userId;
  final String? role;
}

class RoleUpdateRequest {
  RoleUpdateRequest({
    required this.id,
    this.userId,
    this.role,
  });

  final int id;
  final int? userId;
  final String? role;
}

class RoleViewQueryable extends KeyedViewQueryable<RoleView, int> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(int key) => TextEncoder.i.encode(key);

  @override
  String get query => 'SELECT "roles".*, row_to_json("user".*) as "user"'
      'FROM "roles"'
      'LEFT JOIN (${UserViewQueryable().query}) "user"'
      'ON "roles"."user_id" = "user"."id"';

  @override
  String get tableAlias => 'roles';

  @override
  RoleView decode(TypedMap map) => RoleView(
      id: map.get('id'),
      user: map.get('user', UserViewQueryable().decoder),
      role: map.getOpt('role'));
}

class RoleView {
  RoleView({
    required this.id,
    required this.user,
    this.role,
  });

  final int id;
  final UserView user;
  final String? role;
}
