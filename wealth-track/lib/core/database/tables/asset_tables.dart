import 'package:drift/drift.dart';

mixin AssetFields on Table {
  TextColumn get id => text()();
  TextColumn get name => text().withLength(min: 1)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}

@DataClassName('CashAssetRow')
class CashAssets extends Table with AssetFields {
  TextColumn get currency => text()();
  TextColumn get bankName => text()();
  RealColumn get amount => real()();
}

@DataClassName('StockAssetRow')
class StockAssets extends Table with AssetFields {
  TextColumn get symbol => text()();
  TextColumn get market => text()();
  RealColumn get shares => real()();
  RealColumn get avgCost => real()();
  RealColumn get currentPrice => real().nullable()();
  DateTimeColumn get priceUpdatedAt => dateTime().nullable()();
}

@DataClassName('FundAssetRow')
class FundAssets extends Table with AssetFields {
  TextColumn get fundCode => text()();
  RealColumn get units => real()();
  RealColumn get avgCost => real()();
  RealColumn get currentNav => real().nullable()();
  DateTimeColumn get navUpdatedAt => dateTime().nullable()();
}

@DataClassName('CryptoAssetRow')
class CryptoAssets extends Table with AssetFields {
  TextColumn get symbol => text()();
  RealColumn get amount => real()();
  RealColumn get avgCost => real()();
  RealColumn get currentPrice => real().nullable()();
  DateTimeColumn get priceUpdatedAt => dateTime().nullable()();
}

@DataClassName('DailySnapshotRow')
class DailySnapshots extends Table {
  TextColumn get date => text()();
  RealColumn get totalValue => real()();
  RealColumn get cashValue => real().withDefault(const Constant(0))();
  RealColumn get stockValue => real().withDefault(const Constant(0))();
  RealColumn get fundValue => real().withDefault(const Constant(0))();
  RealColumn get cryptoValue => real().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {date};
}

@DataClassName('ExchangeRateRow')
class ExchangeRates extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get fromCurrency => text()();
  TextColumn get toCurrency => text()();
  RealColumn get rate => real()();
  DateTimeColumn get fetchedAt => dateTime()();
}
