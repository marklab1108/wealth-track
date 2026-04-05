import 'package:drift/drift.dart';

import '../../../core/database/app_database.dart';

class ExchangeRateRepository {
  final AppDatabase _db;

  ExchangeRateRepository(this._db);

  /// Gets the latest cached rate for a currency pair.
  Future<double?> getLatestRate(String from, String to) async {
    final query = _db.select(_db.exchangeRates)
      ..where((t) => t.fromCurrency.equals(from) & t.toCurrency.equals(to))
      ..orderBy([(t) => OrderingTerm.desc(t.fetchedAt)])
      ..limit(1);
    final rows = await query.get();
    if (rows.isEmpty) return null;
    return rows.first.rate;
  }

  /// Gets the fetch time of the latest cached rate.
  Future<DateTime?> getLatestFetchedAt(String from, String to) async {
    final query = _db.select(_db.exchangeRates)
      ..where((t) => t.fromCurrency.equals(from) & t.toCurrency.equals(to))
      ..orderBy([(t) => OrderingTerm.desc(t.fetchedAt)])
      ..limit(1);
    final rows = await query.get();
    if (rows.isEmpty) return null;
    return rows.first.fetchedAt;
  }

  /// Inserts a new exchange rate record.
  Future<void> insert(String from, String to, double rate) {
    return _db.into(_db.exchangeRates).insert(
          ExchangeRatesCompanion.insert(
            fromCurrency: from,
            toCurrency: to,
            rate: rate,
            fetchedAt: DateTime.now(),
          ),
        );
  }
}
