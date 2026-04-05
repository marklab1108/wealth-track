import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/database_provider.dart';
import '../data/coingecko_service.dart';
import '../data/exchange_rate_repository.dart';
import '../data/exchange_rate_service.dart';
import '../data/twse_mis_service.dart';
import '../data/twse_service.dart';
import '../data/yahoo_finance_service.dart';
import '../data/yahoo_fund_service.dart';

part 'price_provider.g.dart';

@Riverpod(keepAlive: true)
YahooFinanceService yahooFinanceService(YahooFinanceServiceRef ref) {
  final svc = YahooFinanceService();
  ref.onDispose(() => svc.dispose());
  return svc;
}

@Riverpod(keepAlive: true)
ExchangeRateService exchangeRateService(ExchangeRateServiceRef ref) {
  final svc = ExchangeRateService();
  ref.onDispose(() => svc.dispose());
  return svc;
}

@Riverpod(keepAlive: true)
TwseMisService twseMisService(TwseMisServiceRef ref) {
  final svc = TwseMisService();
  ref.onDispose(() => svc.dispose());
  return svc;
}

@Riverpod(keepAlive: true)
TwseService twseService(TwseServiceRef ref) {
  final svc = TwseService();
  ref.onDispose(() => svc.dispose());
  return svc;
}

@Riverpod(keepAlive: true)
CoinGeckoService coinGeckoService(CoinGeckoServiceRef ref) {
  final svc = CoinGeckoService();
  ref.onDispose(() => svc.dispose());
  return svc;
}

@Riverpod(keepAlive: true)
YahooFundService yahooFundService(YahooFundServiceRef ref) {
  final svc = YahooFundService();
  ref.onDispose(() => svc.dispose());
  return svc;
}

@Riverpod(keepAlive: true)
ExchangeRateRepository exchangeRateRepository(
    ExchangeRateRepositoryRef ref) {
  return ExchangeRateRepository(ref.watch(appDatabaseProvider));
}

const _fxCacheHours = 24;

/// Fetches all currency→TWD rates via a single API call (base=USD, cross-rates).
/// Cached 24h in DB (USD→TWD) + computed cross-rates.
@riverpod
Future<Map<String, double>> allRatesToTwd(AllRatesToTwdRef ref) async {
  final repo = ref.watch(exchangeRateRepositoryProvider);
  final svc = ref.watch(exchangeRateServiceProvider);

  final fetchedAt = await repo.getLatestFetchedAt('USD', 'TWD');
  final needsFresh = fetchedAt == null ||
      DateTime.now().difference(fetchedAt).inHours >= _fxCacheHours;

  if (needsFresh) {
    final allRates = await svc.getAllRates('USD');
    if (allRates != null && allRates.containsKey('TWD')) {
      final twdPerUsd = allRates['TWD']!;
      await repo.insert('USD', 'TWD', twdPerUsd);

      final result = <String, double>{'USD_TWD': twdPerUsd};
      for (final entry in allRates.entries) {
        if (entry.key != 'USD' && entry.key != 'TWD' && entry.value > 0) {
          result['${entry.key}_TWD'] = twdPerUsd / entry.value;
        }
      }
      return result;
    }
  }

  final usdTwd = await repo.getLatestRate('USD', 'TWD') ?? 32.0;
  return {'USD_TWD': usdTwd};
}

/// Convenience accessor: USD→TWD from the full rates map.
@riverpod
Future<double> usdToTwd(UsdToTwdRef ref) async {
  final rates = await ref.watch(allRatesToTwdProvider.future);
  return rates['USD_TWD'] ?? 32.0;
}
