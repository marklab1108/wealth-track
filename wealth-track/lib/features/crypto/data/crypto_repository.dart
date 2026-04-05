import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/models/asset.dart';

const _uuid = Uuid();

class CryptoRepository {
  final AppDatabase _db;

  CryptoRepository(this._db);

  Stream<List<CryptoAsset>> watchAll() {
    final query = _db.select(_db.cryptoAssets)
      ..orderBy([(t) => OrderingTerm(expression: t.symbol)]);
    return query.watch().map(
          (rows) => rows.map(_toDomain).toList(),
        );
  }

  Future<List<CryptoAsset>> getAll() async {
    final rows = await _db.select(_db.cryptoAssets).get();
    return rows.map(_toDomain).toList();
  }

  Future<CryptoAsset> getById(String id) async {
    final row = await (_db.select(_db.cryptoAssets)
          ..where((t) => t.id.equals(id)))
        .getSingle();
    return _toDomain(row);
  }

  Future<void> insert(CryptoAsset asset) {
    return _db.into(_db.cryptoAssets).insert(
          CryptoAssetsCompanion.insert(
            id: asset.id.isEmpty ? _uuid.v4() : asset.id,
            name: asset.name,
            symbol: asset.symbol,
            amount: asset.amount,
            avgCost: asset.avgCost,
          ),
        );
  }

  Future<void> update(CryptoAsset asset) {
    return (_db.update(_db.cryptoAssets)..where((t) => t.id.equals(asset.id)))
        .write(
      CryptoAssetsCompanion(
        name: Value(asset.name),
        symbol: Value(asset.symbol),
        amount: Value(asset.amount),
        avgCost: Value(asset.avgCost),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> updatePriceBySymbol(String symbol, double price) {
    return (_db.update(_db.cryptoAssets)
          ..where((t) => t.symbol.equals(symbol)))
        .write(
      CryptoAssetsCompanion(
        currentPrice: Value(price),
        priceUpdatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> deleteById(String id) {
    return (_db.delete(_db.cryptoAssets)..where((t) => t.id.equals(id))).go();
  }

  CryptoAsset _toDomain(CryptoAssetRow row) {
    return CryptoAsset(
      id: row.id,
      name: row.name,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      symbol: row.symbol,
      amount: row.amount,
      avgCost: row.avgCost,
      currentPrice: row.currentPrice,
      priceUpdatedAt: row.priceUpdatedAt,
    );
  }
}
