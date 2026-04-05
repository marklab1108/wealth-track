import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/providers/database_provider.dart';
import '../data/exchange_rate_repository.dart';
import '../data/exchange_rate_service.dart';
import '../data/yahoo_finance_service.dart';

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
ExchangeRateRepository exchangeRateRepository(
    ExchangeRateRepositoryRef ref) {
  return ExchangeRateRepository(ref.watch(appDatabaseProvider));
}

const _fxCacheHours = 24;

/// Fetches USD→TWD rate. Uses DB cache (24h), falls back to API.
@riverpod
Future<double> usdToTwd(UsdToTwdRef ref) async {
  final repo = ref.watch(exchangeRateRepositoryProvider);
  final svc = ref.watch(exchangeRateServiceProvider);

  final fetchedAt = await repo.getLatestFetchedAt('USD', 'TWD');
  if (fetchedAt != null) {
    final age = DateTime.now().difference(fetchedAt);
    if (age.inHours < _fxCacheHours) {
      final cached = await repo.getLatestRate('USD', 'TWD');
      if (cached != null) return cached;
    }
  }

  final rate = await svc.getRate('USD', 'TWD');
  if (rate != null) {
    await repo.insert('USD', 'TWD', rate);
    return rate;
  }

  final fallback = await repo.getLatestRate('USD', 'TWD');
  return fallback ?? 32.0;
}
