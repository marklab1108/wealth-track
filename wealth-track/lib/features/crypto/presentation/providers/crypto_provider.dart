import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/asset.dart';
import '../../../../core/providers/database_provider.dart';
import '../../../price/providers/price_provider.dart';
import '../../../stock/presentation/providers/stock_provider.dart';
import '../../data/crypto_repository.dart';

part 'crypto_provider.g.dart';

@riverpod
CryptoRepository cryptoRepository(CryptoRepositoryRef ref) {
  return CryptoRepository(ref.watch(appDatabaseProvider));
}

@riverpod
Stream<List<CryptoAsset>> cryptoAssets(CryptoAssetsRef ref) {
  return ref.watch(cryptoRepositoryProvider).watchAll();
}

const _cryptoCacheMinutes = 5;

@riverpod
Future<RefreshResult> refreshCryptoPrices(
    RefreshCryptoPricesRef ref) async {
  final repo = ref.read(cryptoRepositoryProvider);
  final cryptos = await repo.getAll();

  if (cryptos.isEmpty) return const RefreshResult(updated: 0, requested: 0);

  final stale = cryptos.where((c) {
    if (c.priceUpdatedAt == null) return true;
    return DateTime.now().difference(c.priceUpdatedAt!).inMinutes >=
        _cryptoCacheMinutes;
  }).toList();

  if (stale.isEmpty) return const RefreshResult(updated: 0, requested: 0);

  final coingecko = ref.read(coinGeckoServiceProvider);

  final symbolToId = <String, String>{};
  for (final c in stale) {
    final id = await coingecko.getIdBySymbol(c.symbol);
    if (id != null) symbolToId[c.symbol] = id;
  }

  final allFailed = stale
      .where((c) => !symbolToId.containsKey(c.symbol))
      .map((c) => c.symbol)
      .toList();

  if (symbolToId.isEmpty) {
    return RefreshResult(
      updated: 0,
      requested: stale.length,
      failed: allFailed,
    );
  }

  final ids = symbolToId.values.toSet().toList();
  final prices = await coingecko.getPrices(ids);

  int updated = 0;
  for (final entry in symbolToId.entries) {
    final price = prices[entry.value];
    if (price != null) {
      await repo.updatePriceBySymbol(entry.key, price);
      updated++;
    } else {
      allFailed.add(entry.key);
    }
  }

  return RefreshResult(
    updated: updated,
    requested: stale.length,
    failed: allFailed,
  );
}
