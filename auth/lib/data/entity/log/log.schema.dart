// ignore_for_file: annotate_overrides

part of 'log.dart';

extension LogRepositories on Database {
  LogRepository get logs => LogRepository._(this);
}

abstract class LogRepository
    implements
        ModelRepository,
        KeyedModelRepositoryInsert<LogInsertRequest>,
        ModelRepositoryUpdate<LogUpdateRequest>,
        ModelRepositoryDelete<int> {
  factory LogRepository._(Database db) = _LogRepository;

  Future<LogView?> queryLog(int id);
  Future<List<LogView>> queryLogs([QueryParams? params]);
}

class _LogRepository extends BaseRepository
    with
        KeyedRepositoryInsertMixin<LogInsertRequest>,
        RepositoryUpdateMixin<LogUpdateRequest>,
        RepositoryDeleteMixin<int>
    implements LogRepository {
  _LogRepository(super.db) : super(tableName: 'logs', keyName: 'id');

  @override
  Future<LogView?> queryLog(int id) {
    return queryOne(id, LogViewQueryable());
  }

  @override
  Future<List<LogView>> queryLogs([QueryParams? params]) {
    return queryMany(LogViewQueryable(), params);
  }

  @override
  Future<List<int>> insert(List<LogInsertRequest> requests) async {
    if (requests.isEmpty) return [];
    var values = QueryValues();
    var rows = await db.query(
      'INSERT INTO "logs" ( "user_id", "method", "call_date" )\n'
      'VALUES ${requests.map((r) => '( ${values.add(r.userId)}:int8, ${values.add(r.method)}:text, ${values.add(r.callDate)}:text )').join(', ')}\n'
      'RETURNING "id"',
      values.values,
    );
    var result = rows.map<int>((r) => TextEncoder.i.decode(r.toColumnMap()['id'])).toList();

    return result;
  }

  @override
  Future<void> update(List<LogUpdateRequest> requests) async {
    if (requests.isEmpty) return;
    var values = QueryValues();
    await db.query(
      'UPDATE "logs"\n'
      'SET "user_id" = COALESCE(UPDATED."user_id", "logs"."user_id"), "method" = COALESCE(UPDATED."method", "logs"."method"), "call_date" = COALESCE(UPDATED."call_date", "logs"."call_date")\n'
      'FROM ( VALUES ${requests.map((r) => '( ${values.add(r.id)}:int8::int8, ${values.add(r.userId)}:int8::int8, ${values.add(r.method)}:text::text, ${values.add(r.callDate)}:text::text )').join(', ')} )\n'
      'AS UPDATED("id", "user_id", "method", "call_date")\n'
      'WHERE "logs"."id" = UPDATED."id"',
      values.values,
    );
  }
}

class LogInsertRequest {
  LogInsertRequest({
    required this.userId,
    required this.method,
    required this.callDate,
  });

  final int userId;
  final String method;
  final String callDate;
}

class LogUpdateRequest {
  LogUpdateRequest({
    required this.id,
    this.userId,
    this.method,
    this.callDate,
  });

  final int id;
  final int? userId;
  final String? method;
  final String? callDate;
}

class LogViewQueryable extends KeyedViewQueryable<LogView, int> {
  @override
  String get keyName => 'id';

  @override
  String encodeKey(int key) => TextEncoder.i.encode(key);

  @override
  String get query => 'SELECT "logs".*'
      'FROM "logs"';

  @override
  String get tableAlias => 'logs';

  @override
  LogView decode(TypedMap map) => LogView(
      id: map.get('id'),
      userId: map.get('user_id'),
      method: map.get('method'),
      callDate: map.get('call_date'));
}

class LogView {
  LogView({
    required this.id,
    required this.userId,
    required this.method,
    required this.callDate,
  });

  final int id;
  final int userId;
  final String method;
  final String callDate;
}
