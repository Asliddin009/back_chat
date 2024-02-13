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
      'INSERT INTO "roles" ( "name", "is_create", "is_read", "is_update", "is_delete" )\n'
      'VALUES ${requests.map((r) => '( ${values.add(r.name)}:text, ${values.add(r.isCreate)}:boolean, ${values.add(r.isRead)}:boolean, ${values.add(r.isUpdate)}:boolean, ${values.add(r.isDelete)}:boolean )').join(', ')}\n'
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
      'SET "name" = COALESCE(UPDATED."name", "roles"."name"), "is_create" = COALESCE(UPDATED."is_create", "roles"."is_create"), "is_read" = COALESCE(UPDATED."is_read", "roles"."is_read"), "is_update" = COALESCE(UPDATED."is_update", "roles"."is_update"), "is_delete" = COALESCE(UPDATED."is_delete", "roles"."is_delete")\n'
      'FROM ( VALUES ${requests.map((r) => '( ${values.add(r.id)}:int8::int8, ${values.add(r.name)}:text::text, ${values.add(r.isCreate)}:boolean::boolean, ${values.add(r.isRead)}:boolean::boolean, ${values.add(r.isUpdate)}:boolean::boolean, ${values.add(r.isDelete)}:boolean::boolean )').join(', ')} )\n'
      'AS UPDATED("id", "name", "is_create", "is_read", "is_update", "is_delete")\n'
      'WHERE "roles"."id" = UPDATED."id"',
      values.values,
    );
  }
}

class RoleInsertRequest {
  RoleInsertRequest({
    required this.name,
    required this.isCreate,
    required this.isRead,
    required this.isUpdate,
    required this.isDelete,
  });

  final String name;
  final bool isCreate;
  final bool isRead;
  final bool isUpdate;
  final bool isDelete;
}

class RoleUpdateRequest {
  RoleUpdateRequest({
    required this.id,
    this.name,
    this.isCreate,
    this.isRead,
    this.isUpdate,
    this.isDelete,
  });

  final int id;
  final String? name;
  final bool? isCreate;
  final bool? isRead;
  final bool? isUpdate;
  final bool? isDelete;
}

class RoleViewQueryable extends KeyedViewQueryable<RoleView, int> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(int key) => TextEncoder.i.encode(key);

  @override
  String get query => 'SELECT "roles".*'
      'FROM "roles"';

  @override
  String get tableAlias => 'roles';

  @override
  RoleView decode(TypedMap map) => RoleView(
      id: map.get('id'),
      name: map.get('name'),
      isCreate: map.get('is_create'),
      isRead: map.get('is_read'),
      isUpdate: map.get('is_update'),
      isDelete: map.get('is_delete'));
}

class RoleView {
  RoleView({
    required this.id,
    required this.name,
    required this.isCreate,
    required this.isRead,
    required this.isUpdate,
    required this.isDelete,
  });

  final int id;
  final String name;
  final bool isCreate;
  final bool isRead;
  final bool isUpdate;
  final bool isDelete;
}
