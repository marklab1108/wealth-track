import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/asset.dart';
import '../../../cash/presentation/providers/cash_provider.dart';
import '../../../price/providers/price_provider.dart';
import '../../../stock/presentation/providers/stock_provider.dart';

part 'dashboard_provider.g.dart';

@riverpod
Future<double> totalValue(TotalValueRef ref) async {
  final cashList = ref.watch(cashAssetsProvider).valueOrNull ?? <CashAsset>[];
  final stockList =
      ref.watch(allStockAssetsProvider).valueOrNull ?? <StockAsset>[];

  final cashTotal = cashList.fold(0.0, (sum, a) => sum + a.amount);

  if (stockList.isEmpty) return cashTotal;

  final usdToTwd = await ref.watch(usdToTwdProvider.future);
  final stockTotalTWD = stockList.fold<double>(0.0, (sum, s) {
    final mv = s.marketValue;
    if (s.market == StockMarket.us) return sum + mv * usdToTwd;
    return sum + mv;
  });

  return cashTotal + stockTotalTWD;
}

@riverpod
Future<Map<String, double>> assetAllocation(AssetAllocationRef ref) async {
  final cashList = ref.watch(cashAssetsProvider).valueOrNull ?? <CashAsset>[];
  final stockList =
      ref.watch(allStockAssetsProvider).valueOrNull ?? <StockAsset>[];

  final result = <String, double>{};

  final cashTotal = cashList.fold<double>(0.0, (sum, a) => sum + a.amount);
  if (cashTotal > 0) result['現金'] = cashTotal;

  if (stockList.isNotEmpty) {
    final usdToTwd = await ref.watch(usdToTwdProvider.future);

    double usTotal = 0;
    double twTotal = 0;
    for (final s in stockList) {
      final mv = s.marketValue;
      if (s.market == StockMarket.us) {
        usTotal += mv * usdToTwd;
      } else {
        twTotal += mv;
      }
    }

    if (usTotal > 0) result['美股'] = usTotal;
    if (twTotal > 0) result['台股'] = twTotal;
  }

  return result;
}

@riverpod
double cashTotalValue(CashTotalValueRef ref) {
  final list = ref.watch(cashAssetsProvider).valueOrNull ?? <CashAsset>[];
  return list.fold(0.0, (sum, a) => sum + a.amount);
}

@riverpod
Future<double> usStockTotalTWD(UsStockTotalTWDRef ref) async {
  final list = ref.watch(stockAssetsProvider).valueOrNull ?? <StockAsset>[];
  if (list.isEmpty) return 0;

  final usdToTwd = await ref.watch(usdToTwdProvider.future);
  return list.fold<double>(0.0, (sum, s) => sum + s.marketValue * usdToTwd);
}

@riverpod
double twStockTotal(TwStockTotalRef ref) {
  final list = ref.watch(twStockAssetsProvider).valueOrNull ?? <StockAsset>[];
  return list.fold(0.0, (sum, s) => sum + s.marketValue);
}
