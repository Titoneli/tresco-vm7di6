import '../database.dart';

class ControleRefreshViewTable extends SupabaseTable<ControleRefreshViewRow> {
  @override
  String get tableName => 'controle_refresh_view';

  @override
  ControleRefreshViewRow createRow(Map<String, dynamic> data) =>
      ControleRefreshViewRow(data);
}

class ControleRefreshViewRow extends SupabaseDataRow {
  ControleRefreshViewRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => ControleRefreshViewTable();

  String get viewName => getField<String>('view_name')!;
  set viewName(String value) => setField<String>('view_name', value);

  DateTime? get lastRefresh => getField<DateTime>('last_refresh');
  set lastRefresh(DateTime? value) => setField<DateTime>('last_refresh', value);
}
