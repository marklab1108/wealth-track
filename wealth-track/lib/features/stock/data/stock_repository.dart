import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../../core/database/app_database.dart';
import '../../../core/models/asset.dart';

const _uuid = Uuid();

class StockRepository {
  final AppDatabase _db;

  StockRepository(this._db);

  Stream<List<StockAsset>> watchAll({StockMarket? market}) {
    final query = _db.select(_db.stockAssets)
      ..orderBy([(t) => OrderingTerm(expression: t.symbol)]);
    if (market != null) {
      query.where((t) => t.market.equals(market.name));
    }
    return query.watch().map(
          (rows) => rows.map(_toDomain).toList(),
        );
  }

  Future<List<StockAsset>> getAll() async {
    final rows = await _db.select(_db.stockAssets).get();
    return rows.map(_toDomain).toList();
  }

  Future<StockAsset> getById(String id) async {
    final row = await (_db.select(_db.stockAssets)
          ..where((t) => t.id.equals(id)))
        .getSingle();
    return _toDomain(row);
  }

  Future<void> insert(StockAsset asset) {
    return _db.into(_db.stockAssets).insert(
          StockAssetsCompanion.insert(
            id: asset.id.isEmpty ? _uuid.v4() : asset.id,
            name: asset.name,
            symbol: asset.symbol,
            market: asset.market.name,
            shares: asset.shares,
            avgCost: asset.avgCost,
          ),
        );
  }

  Future<void> update(StockAsset asset) {
    return (_db.update(_db.stockAssets)..where((t) => t.id.equals(asset.id)))
        .write(
      StockAssetsCompanion(
        name: Value(asset.name),
        symbol: Value(asset.symbol),
        market: Value(asset.market.name),
        shares: Value(asset.shares),
        avgCost: Value(asset.avgCost),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> updatePrice(String id, double price) {
    return (_db.update(_db.stockAssets)..where((t) => t.id.equals(id))).write(
      StockAssetsCompanion(
        currentPrice: Value(price),
        priceUpdatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> updatePriceBySymbol(String symbol, double price) {
    return (_db.update(_db.stockAssets)
          ..where((t) => t.symbol.equals(symbol)))
        .write(
      StockAssetsCompanion(
        currentPrice: Value(price),
        priceUpdatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> deleteById(String id) {
    return (_db.delete(_db.stockAssets)..where((t) => t.id.equals(id))).go();
  }

  StockAsset _toDomain(StockAssetRow row) {
    return StockAsset(
      id: row.id,
      name: row.name,
      createdAt: row.createdAt,
      updatedAt: row.updatedAt,
      symbol: row.symbol,
      market: StockMarket.values.byName(row.market),
      shares: row.shares,
      avgCost: row.avgCost,
      currentPrice: row.currentPrice,
      priceUpdatedAt: row.priceUpdatedAt,
    );
  }
}
