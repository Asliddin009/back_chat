// ignore_for_file: annotate_overrides

part of 'user.dart';

extension UserRepositories on Database {
  UserRepository get users => UserRepository._(this);
}

abstract class UserRepository
    implements
        ModelRepository,
        KeyedModelRepositoryInsert<UserInsertRequest>,
        ModelRepositoryUpdate<UserUpdateRequest>,
        ModelRepositoryDelete<int> {
  factory UserRepository._(Database db) = _UserRepository;

  Future<UserView?> queryUser(int id);
  Future<List<UserView>> queryUsers([QueryParams? params]);
}

class _UserRepository extends BaseRepository
    with
        KeyedRepositoryInsertMixin<UserInsertRequest>,
        RepositoryUpdateMixin<UserUpdateRequest>,
        RepositoryDeleteMixin<int>
    implements UserRepository {
  _UserRepository(super.db) : super(tableName: 'users', keyName: 'id');

  @override
  Future<UserView?> queryUser(int id) {
    return queryOne(id, UserViewQueryable());
  }

  @override
  Future<List<UserView>> queryUsers([QueryParams? params]) {
    return queryMany(UserViewQueryable(), params);
  }

  @override
  Future<List<int>> insert(List<UserInsertRequest> requests) async {
    if (requests.isEmpty) return [];
    var values = QueryValues();
    var rows = await db.query(
      'INSERT INTO "users" ( "username", "role_list", "email", "password", "phone", "avatar", "first_name", "last_name", "code", "code_life" )\n'
      'VALUES ${requests.map((r) => '( ${values.add(r.username)}:text, ${values.add(r.roleList)}:_int8, ${values.add(r.email)}:text, ${values.add(r.password)}:text, ${values.add(r.phone)}:text, ${values.add(r.avatar)}:text, ${values.add(r.firstName)}:text, ${values.add(r.lastName)}:text, ${values.add(r.code)}:text, ${values.add(r.codeLife)}:text )').join(', ')}\n'
      'RETURNING "id"',
      values.values,
    );
    var result = rows
        .map<int>((r) => TextEncoder.i.decode(r.toColumnMap()['id']))
        .toList();

    return result;
  }

  @override
  Future<void> update(List<UserUpdateRequest> requests) async {
    if (requests.isEmpty) return;
    var values = QueryValues();
    await db.query(
      'UPDATE "users"\n'
      'SET "username" = COALESCE(UPDATED."username", "users"."username"), "role_list" = COALESCE(UPDATED."role_list", "users"."role_list"), "email" = COALESCE(UPDATED."email", "users"."email"), "password" = COALESCE(UPDATED."password", "users"."password"), "phone" = COALESCE(UPDATED."phone", "users"."phone"), "avatar" = COALESCE(UPDATED."avatar", "users"."avatar"), "first_name" = COALESCE(UPDATED."first_name", "users"."first_name"), "last_name" = COALESCE(UPDATED."last_name", "users"."last_name"), "code" = COALESCE(UPDATED."code", "users"."code"), "code_life" = COALESCE(UPDATED."code_life", "users"."code_life")\n'
      'FROM ( VALUES ${requests.map((r) => '( ${values.add(r.id)}:int8::int8, ${values.add(r.username)}:text::text, ${values.add(r.roleList)}:_int8::_int8, ${values.add(r.email)}:text::text, ${values.add(r.password)}:text::text, ${values.add(r.phone)}:text::text, ${values.add(r.avatar)}:text::text, ${values.add(r.firstName)}:text::text, ${values.add(r.lastName)}:text::text, ${values.add(r.code)}:text::text, ${values.add(r.codeLife)}:text::text )').join(', ')} )\n'
      'AS UPDATED("id", "username", "role_list", "email", "password", "phone", "avatar", "first_name", "last_name", "code", "code_life")\n'
      'WHERE "users"."id" = UPDATED."id"',
      values.values,
    );
  }
}

class UserInsertRequest {
  UserInsertRequest({
    required this.username,
    required this.roleList,
    this.email,
    this.password,
    this.phone,
    this.avatar,
    this.firstName,
    this.lastName,
    this.code,
    this.codeLife,
  });

  final String username;
  final List<int> roleList;
  final String? email;
  final String? password;
  final String? phone;
  final String? avatar;
  final String? firstName;
  final String? lastName;
  final String? code;
  final String? codeLife;
}

class UserUpdateRequest {
  UserUpdateRequest({
    required this.id,
    this.username,
    this.roleList,
    this.email,
    this.password,
    this.phone,
    this.avatar,
    this.firstName,
    this.lastName,
    this.code,
    this.codeLife,
  });

  final int id;
  final String? username;
  final List<int>? roleList;
  final String? email;
  final String? password;
  final String? phone;
  final String? avatar;
  final String? firstName;
  final String? lastName;
  final String? code;
  final String? codeLife;
}

class UserViewQueryable extends KeyedViewQueryable<UserView, int> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(int key) => TextEncoder.i.encode(key);

  @override
  String get query => 'SELECT "users".*'
      'FROM "users"';

  @override
  String get tableAlias => 'users';

  @override
  UserView decode(TypedMap map) => UserView(
      id: map.get('id'),
      username: map.get('username'),
      roleList: map.getListOpt('role_list') ?? const [],
      email: map.getOpt('email'),
      password: map.getOpt('password'),
      phone: map.getOpt('phone'),
      avatar: map.getOpt('avatar'),
      firstName: map.getOpt('first_name'),
      lastName: map.getOpt('last_name'),
      code: map.getOpt('code'),
      codeLife: map.getOpt('code_life'));
}

class UserView {
  UserView({
    required this.id,
    required this.username,
    required this.roleList,
    this.email,
    this.password,
    this.phone,
    this.avatar,
    this.firstName,
    this.lastName,
    this.code,
    this.codeLife,
  });

  final int id;
  final String username;
  final List<int> roleList;
  final String? email;
  final String? password;
  final String? phone;
  final String? avatar;
  final String? firstName;
  final String? lastName;
  final String? code;
  final String? codeLife;
}
