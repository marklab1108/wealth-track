import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/models/asset.dart';

const _uuid = Uuid();

class CashRepository {
  final AppDatabase _db;

  CashRepository(this._db);

  Stream<List<CashAsset>> watchAll() {
    final query = _db.select(_db.cashAssets)
      ..orderBy([
        (t) => OrderingTerm(expression: t.bankName),
        (t) => OrderingTerm(expression: t.currency),
      ]);
    return query.watch().map(
          (rows) => rows.map(_toDomain).toList(),
        );
  }

  Future<List<CashAsset>> getAll() async {
    final rows = await _db.select(_db.cashAssets).get();
    return rows.map(_toDomain).toList();
  }

  Future<CashAsset> getById(String id) async {
    final row = await (_db.select(_db.cashAssets)
          ..where((t) => t.id.equals(id)))
        .getSingle();
    return _toDomain(row);
  }

  Future<void> insert(CashAsset asset) {
    return _db.into(_db.cashAssets).insert(
          CashAssetsCompanion.insert(
            id: asset.id.isEmpty ? _uuid.v4() : asset.id,
            name: asset.name,
            currency: asset.currency.name,
            bankName: asset.bankName,
            amount: asset.amount,
          ),
        );
  }

  Future<void> update(CashAsset asset) {
    return (_db.update(_db.cashAssets)..where((t) => t.id.equals(asset.id)))
        .write(
      CashAssetsCompanion(
        name: Value(asset.name),
        currency: Value(asset.currency.name),
        bankName: Value(asset.bankName),
        amount: Value(asset.amount),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> deleteById(String id) {
    return (_db.delete(_db.cashAssets)..where((t) => t.id.equals(id))).go();
  }

  CashAsset _toDomain(CashAssetRow row) {
    return CashAsset(
      id: row.id,
      name: row.name,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      currency: CurrencyCode.values.byName(row.currency),
      bankName: row.bankName,
      amount: row.amount,
    );
  }
}
