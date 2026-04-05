import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/asset.dart';
import '../../../../core/providers/database_provider.dart';
import '../../../price/providers/price_provider.dart';
import '../../data/stock_repository.dart';

part 'stock_provider.g.dart';

@riverpod
StockRepository stockRepository(StockRepositoryRef ref) {
  return StockRepository(ref.watch(appDatabaseProvider));
}

@riverpod
Stream<List<StockAsset>> stockAssets(StockAssetsRef ref) {
  return ref.watch(stockRepositoryProvider).watchAll(market: StockMarket.us);
}

@riverpod
Stream<List<StockAsset>> twStockAssets(TwStockAssetsRef ref) {
  return ref.watch(stockRepositoryProvider).watchAll(market: StockMarket.tw);
}

@riverpod
Stream<List<StockAsset>> allStockAssets(AllStockAssetsRef ref) {
  return ref.watch(stockRepositoryProvider).watchAll();
}

class RefreshResult {
  final int updated;
  final int requested;
  final List<String> failed;

  const RefreshResult({
    required this.updated,
    required this.requested,
    this.failed = const [],
  });
}

String toYahooSymbol(String symbol, StockMarket market) {
  if (market == StockMarket.tw) return '$symbol.TW';
  return symbol;
}

@riverpod
Future<RefreshResult> refreshStockPrices(RefreshStockPricesRef ref) async {
  final repo = ref.read(stockRepositoryProvider);
  final stocks = await repo.getAll();

  if (stocks.isEmpty) return const RefreshResult(updated: 0, requested: 0);

  final stale = stocks.where((s) {
    if (s.priceUpdatedAt == null) return true;
    return DateTime.now().difference(s.priceUpdatedAt!).inMinutes >= 15;
  }).toList();

  if (stale.isEmpty) return const RefreshResult(updated: 0, requested: 0);

  int totalUpdated = 0;
  final allFailed = <String>[];

  // --- TW stocks: use TWSE MIS API (5s delay) ---
  final twStale =
      stale.where((s) => s.market == StockMarket.tw).toList();
  if (twStale.isNotEmpty) {
    final mis = ref.read(twseMisServiceProvider);
    final twCodes = twStale.map((s) => s.symbol).toList();
    final misQuotes = await mis.getQuotes(twCodes);

    for (final code in twCodes) {
      final quote = misQuotes[code];
      if (quote?.price != null) {
        await repo.updatePriceBySymbol(code, quote!.price!);
        totalUpdated++;
      }
    }

    // Fallback: try Yahoo Finance for TW stocks MIS couldn't find
    final twMissing =
        twCodes.where((c) => misQuotes[c]?.price == null).toList();
    if (twMissing.isNotEmpty) {
      final yahoo = ref.read(yahooFinanceServiceProvider);
      final yahooSymbols = twMissing.map((c) => '$c.TW').toList();
      final yahooPrices = await yahoo.getPrices(yahooSymbols);

      for (final code in twMissing) {
        final yahooKey = '$code.TW';
        final price = yahooPrices[yahooKey];
        if (price != null) {
          await repo.updatePriceBySymbol(code, price);
          totalUpdated++;
        } else {
          allFailed.add(code);
        }
      }
    }
  }

  // --- US stocks: use Yahoo Finance ---
  final usStale =
      stale.where((s) => s.market == StockMarket.us).toList();
  if (usStale.isNotEmpty) {
    final yahoo = ref.read(yahooFinanceServiceProvider);
    final usSymbols = usStale.map((s) => s.symbol).toList();
    final prices = await yahoo.getPrices(usSymbols);

    for (final entry in prices.entries) {
      await repo.updatePriceBySymbol(entry.key, entry.value);
      totalUpdated++;
    }

    final usFailed =
        usSymbols.where((s) => !prices.containsKey(s)).toList();
    allFailed.addAll(usFailed);
  }

  return RefreshResult(
    updated: totalUpdated,
    requested: stale.length,
    failed: allFailed,
  );
}
