import '../database.dart';

class RettotdashboardTable extends SupabaseTable<RettotdashboardRow> {
  @override
  String get tableName => 'rettotdashboard';

  @override
  RettotdashboardRow createRow(Map<String, dynamic> data) =>
      RettotdashboardRow(data);
}

class RettotdashboardRow extends SupabaseDataRow {
  RettotdashboardRow(Map<String, dynamic> data) : super(data);

  @override
  SupabaseTable get table => RettotdashboardTable();

  int? get ta => getField<int>('ta');
  set ta(int? value) => setField<int>('ta', value);

  int? get tp => getField<int>('tp');
  set tp(int? value) => setField<int>('tp', value);

  int? get ti => getField<int>('ti');
  set ti(int? value) => setField<int>('ti', value);

  int? get tm => getField<int>('tm');
  set tm(int? value) => setField<int>('tm', value);

  int? get te => getField<int>('te');
  set te(int? value) => setField<int>('te', value);

  int? get tg => getField<int>('tg');
  set tg(int? value) => setField<int>('tg', value);

  int? get taa => getField<int>('taa');
  set taa(int? value) => setField<int>('taa', value);

  int? get tar => getField<int>('tar');
  set tar(int? value) => setField<int>('tar', value);
}
