import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/asset.dart';
import '../../../../core/providers/database_provider.dart';
import '../../../price/providers/price_provider.dart';
import '../../../stock/presentation/providers/stock_provider.dart';
import '../../data/fund_repository.dart';

part 'fund_provider.g.dart';

@riverpod
FundRepository fundRepository(FundRepositoryRef ref) {
  return FundRepository(ref.watch(appDatabaseProvider));
}

@riverpod
Stream<List<FundAsset>> fundAssets(FundAssetsRef ref) {
  return ref.watch(fundRepositoryProvider).watchAll();
}

@riverpod
double fundTotal(FundTotalRef ref) {
  final list = ref.watch(fundAssetsProvider).valueOrNull ?? [];
  return list.fold(0.0, (sum, a) => sum + a.marketValue);
}

const _fundCacheHours = 4;

@riverpod
Future<RefreshResult> refreshFundPrices(RefreshFundPricesRef ref) async {
  final repo = ref.read(fundRepositoryProvider);
  final funds = await repo.getAll();

  if (funds.isEmpty) return const RefreshResult(updated: 0, requested: 0);

  final stale = funds.where((f) {
    if (f.navUpdatedAt == null) return true;
    return DateTime.now().difference(f.navUpdatedAt!).inHours >=
        _fundCacheHours;
  }).toList();

  if (stale.isEmpty) return const RefreshResult(updated: 0, requested: 0);

  final svc = ref.read(yahooFundServiceProvider);
  final codes = stale.map((f) => f.fundCode).toList();
  final quotes = await svc.getQuotes(codes);

  int updated = 0;
  final failed = <String>[];

  for (final fund in stale) {
    final quote = quotes[fund.fundCode];
    if (quote != null) {
      await repo.updateNavByFundCode(fund.fundCode, quote.nav);
      updated++;
    } else {
      failed.add(fund.fundCode);
    }
  }

  return RefreshResult(
    updated: updated,
    requested: stale.length,
    failed: failed,
  );
}
