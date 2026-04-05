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

@riverpod
Future<RefreshResult> refreshStockPrices(RefreshStockPricesRef ref) async {
  final repo = ref.read(stockRepositoryProvider);
  final yahoo = ref.read(yahooFinanceServiceProvider);
  final stocks = await repo.getAll();

  final usStocks = stocks.where((s) => s.market == StockMarket.us).toList();
  if (usStocks.isEmpty) return const RefreshResult(updated: 0, requested: 0);

  final stale = usStocks.where((s) {
    if (s.priceUpdatedAt == null) return true;
    return DateTime.now().difference(s.priceUpdatedAt!).inMinutes >= 15;
  }).toList();

  if (stale.isEmpty) return const RefreshResult(updated: 0, requested: 0);

  final symbols = stale.map((s) => s.symbol).toList();
  final prices = await yahoo.getPrices(symbols);

  for (final entry in prices.entries) {
    await repo.updatePriceBySymbol(entry.key, entry.value);
  }

  final failedSymbols =
      symbols.where((s) => !prices.containsKey(s)).toList();

  return RefreshResult(
    updated: prices.length,
    requested: symbols.length,
    failed: failedSymbols,
  );
}
