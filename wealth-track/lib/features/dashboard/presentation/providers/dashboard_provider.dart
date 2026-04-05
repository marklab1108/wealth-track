import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/asset.dart';
import '../../../cash/presentation/providers/cash_provider.dart';

part 'dashboard_provider.g.dart';

@riverpod
double totalValue(TotalValueRef ref) {
  final list = ref.watch(cashAssetsProvider).valueOrNull ?? <CashAsset>[];
  return list.fold(0.0, (sum, a) => sum + a.amount);
}

@riverpod
Map<String, double> assetAllocation(AssetAllocationRef ref) {
  final list = ref.watch(cashAssetsProvider).valueOrNull ?? <CashAsset>[];
  final byBank = <String, double>{};
  for (final a in list) {
    byBank[a.bankName] = (byBank[a.bankName] ?? 0) + a.amount;
  }
  return byBank;
}
