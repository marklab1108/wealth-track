import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/asset.dart';
import '../../../../core/providers/database_provider.dart';
import '../../data/cash_repository.dart';

part 'cash_provider.g.dart';

@riverpod
CashRepository cashRepository(CashRepositoryRef ref) {
  return CashRepository(ref.watch(appDatabaseProvider));
}

@riverpod
Stream<List<CashAsset>> cashAssets(CashAssetsRef ref) {
  return ref.watch(cashRepositoryProvider).watchAll();
}

@riverpod
double cashTotal(CashTotalRef ref) {
  final list = ref.watch(cashAssetsProvider).valueOrNull ?? [];
  return list.fold(0.0, (sum, a) => sum + a.amount);
}

@riverpod
Map<String, double> cashByBank(CashByBankRef ref) {
  final list = ref.watch(cashAssetsProvider).valueOrNull ?? [];
  final map = <String, double>{};
  for (final a in list) {
    map[a.bankName] = (map[a.bankName] ?? 0) + a.amount;
  }
  return map;
}
