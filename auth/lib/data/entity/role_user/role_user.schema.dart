// ignore_for_file: annotate_overrides

part of 'role_user.dart';

extension RoleUserRepositories on Database {
  RoleUserRepository get roleUsers => RoleUserRepository._(this);
}

abstract class RoleUserRepository
    implements
        ModelRepository,
        KeyedModelRepositoryInsert<RoleUserInsertRequest>,
        ModelRepositoryUpdate<RoleUserUpdateRequest>,
        ModelRepositoryDelete<int> {
  factory RoleUserRepository._(Database db) = _RoleUserRepository;

  Future<RoleUserView?> queryRoleUser(int id);
  Future<List<RoleUserView>> queryRoleUsers([QueryParams? params]);
}

class _RoleUserRepository extends BaseRepository
    with
        KeyedRepositoryInsertMixin<RoleUserInsertRequest>,
        RepositoryUpdateMixin<RoleUserUpdateRequest>,
        RepositoryDeleteMixin<int>
    implements RoleUserRepository {
  _RoleUserRepository(super.db) : super(tableName: 'role_users', keyName: 'id');

  @override
  Future<RoleUserView?> queryRoleUser(int id) {
    return queryOne(id, RoleUserViewQueryable());
  }

  @override
  Future<List<RoleUserView>> queryRoleUsers([QueryParams? params]) {
    return queryMany(RoleUserViewQueryable(), params);
  }

  @override
  Future<List<int>> insert(List<RoleUserInsertRequest> requests) async {
    if (requests.isEmpty) return [];
    var values = QueryValues();
    var rows = await db.query(
      'INSERT INTO "role_users" ( "role_id", "user_id" )\n'
      'VALUES ${requests.map((r) => '( ${values.add(r.roleId)}:int8, ${values.add(r.userId)}:int8 )').join(', ')}\n'
      'RETURNING "id"',
      values.values,
    );
    var result = rows.map<int>((r) => TextEncoder.i.decode(r.toColumnMap()['id'])).toList();

    return result;
  }

  @override
  Future<void> update(List<RoleUserUpdateRequest> requests) async {
    if (requests.isEmpty) return;
    var values = QueryValues();
    await db.query(
      'UPDATE "role_users"\n'
      'SET "role_id" = COALESCE(UPDATED."role_id", "role_users"."role_id"), "user_id" = COALESCE(UPDATED."user_id", "role_users"."user_id")\n'
      'FROM ( VALUES ${requests.map((r) => '( ${values.add(r.id)}:int8::int8, ${values.add(r.roleId)}:int8::int8, ${values.add(r.userId)}:int8::int8 )').join(', ')} )\n'
      'AS UPDATED("id", "role_id", "user_id")\n'
      'WHERE "role_users"."id" = UPDATED."id"',
      values.values,
    );
  }
}

class RoleUserInsertRequest {
  RoleUserInsertRequest({
    required this.roleId,
    required this.userId,
  });

  final int roleId;
  final int userId;
}

class RoleUserUpdateRequest {
  RoleUserUpdateRequest({
    required this.id,
    this.roleId,
    this.userId,
  });

  final int id;
  final int? roleId;
  final int? userId;
}

class RoleUserViewQueryable extends KeyedViewQueryable<RoleUserView, int> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(int key) => TextEncoder.i.encode(key);

  @override
  String get query =>
      'SELECT "role_users".*, row_to_json("role".*) as "role", row_to_json("user".*) as "user"'
      'FROM "role_users"'
      'LEFT JOIN (${RoleViewQueryable().query}) "role"'
      'ON "role_users"."role_id" = "role"."id"'
      'LEFT JOIN (${UserViewQueryable().query}) "user"'
      'ON "role_users"."user_id" = "user"."id"';

  @override
  String get tableAlias => 'role_users';

  @override
  RoleUserView decode(TypedMap map) => RoleUserView(
      id: map.get('id'),
      role: map.get('role', RoleViewQueryable().decoder),
      user: map.get('user', UserViewQueryable().decoder));
}

class RoleUserView {
  RoleUserView({
    required this.id,
    required this.role,
    required this.user,
  });

  final int id;
  final RoleView role;
  final UserView user;
}
