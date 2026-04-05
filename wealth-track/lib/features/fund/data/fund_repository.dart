import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/models/asset.dart';

const _uuid = Uuid();

class FundRepository {
  final AppDatabase _db;

  FundRepository(this._db);

  Stream<List<FundAsset>> watchAll() {
    final query = _db.select(_db.fundAssets)
      ..orderBy([(t) => OrderingTerm(expression: t.fundCode)]);
    return query.watch().map(
          (rows) => rows.map(_toDomain).toList(),
        );
  }

  Future<List<FundAsset>> getAll() async {
    final rows = await _db.select(_db.fundAssets).get();
    return rows.map(_toDomain).toList();
  }

  Future<FundAsset> getById(String id) async {
    final row = await (_db.select(_db.fundAssets)
          ..where((t) => t.id.equals(id)))
        .getSingle();
    return _toDomain(row);
  }

  Future<void> insert(FundAsset asset) {
    return _db.into(_db.fundAssets).insert(
          FundAssetsCompanion.insert(
            id: asset.id.isEmpty ? _uuid.v4() : asset.id,
            name: asset.name,
            fundCode: asset.fundCode,
            units: asset.units,
            avgCost: asset.avgCost,
            currentNav: Value(asset.currentNav),
            navUpdatedAt: Value(asset.navUpdatedAt),
          ),
        );
  }

  Future<void> update(FundAsset asset) {
    return (_db.update(_db.fundAssets)..where((t) => t.id.equals(asset.id)))
        .write(
      FundAssetsCompanion(
        name: Value(asset.name),
        fundCode: Value(asset.fundCode),
        units: Value(asset.units),
        avgCost: Value(asset.avgCost),
        currentNav: Value(asset.currentNav),
        navUpdatedAt: Value(asset.navUpdatedAt),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> updateNavByFundCode(String fundCode, double nav) {
    return (_db.update(_db.fundAssets)
          ..where((t) => t.fundCode.equals(fundCode)))
        .write(
      FundAssetsCompanion(
        currentNav: Value(nav),
        navUpdatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> deleteById(String id) {
    return (_db.delete(_db.fundAssets)..where((t) => t.id.equals(id))).go();
  }

  FundAsset _toDomain(FundAssetRow row) {
    return FundAsset(
      id: row.id,
      name: row.name,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      fundCode: row.fundCode,
      units: row.units,
      avgCost: row.avgCost,
      currentNav: row.currentNav,
      navUpdatedAt: row.navUpdatedAt,
    );
  }
}
