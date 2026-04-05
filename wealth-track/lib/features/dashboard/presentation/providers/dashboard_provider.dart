import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/models/asset.dart';
import '../../../cash/presentation/providers/cash_provider.dart';
import '../../../crypto/presentation/providers/crypto_provider.dart';
import '../../../fund/presentation/providers/fund_provider.dart';
import '../../../price/providers/price_provider.dart';
import '../../../stock/presentation/providers/stock_provider.dart';

part 'dashboard_provider.g.dart';

@riverpod
Future<double> totalValue(TotalValueRef ref) async {
  final cashList = ref.watch(cashAssetsProvider).valueOrNull ?? <CashAsset>[];
  final stockList =
      ref.watch(allStockAssetsProvider).valueOrNull ?? <StockAsset>[];
  final fundList = ref.watch(fundAssetsProvider).valueOrNull ?? <FundAsset>[];
  final cryptoList =
      ref.watch(cryptoAssetsProvider).valueOrNull ?? <CryptoAsset>[];

  final rates = await ref.watch(allRatesToTwdProvider.future);

  double total = 0;
  for (final a in cashList) {
    total += a.valueTWD(rates);
  }
  for (final s in stockList) {
    total += s.valueTWD(rates);
  }
  for (final f in fundList) {
    total += f.valueTWD(rates);
  }
  for (final c in cryptoList) {
    total += c.valueTWD(rates);
  }

  return total;
}

@riverpod
Future<Map<String, double>> assetAllocation(AssetAllocationRef ref) async {
  final cashList = ref.watch(cashAssetsProvider).valueOrNull ?? <CashAsset>[];
  final stockList =
      ref.watch(allStockAssetsProvider).valueOrNull ?? <StockAsset>[];
  final fundList = ref.watch(fundAssetsProvider).valueOrNull ?? <FundAsset>[];
  final cryptoList =
      ref.watch(cryptoAssetsProvider).valueOrNull ?? <CryptoAsset>[];

  final rates = await ref.watch(allRatesToTwdProvider.future);
  final result = <String, double>{};

  final cashTotal =
      cashList.fold<double>(0.0, (sum, a) => sum + a.valueTWD(rates));
  if (cashTotal > 0) result['現金'] = cashTotal;

  double usTotal = 0;
  double twTotal = 0;
  for (final s in stockList) {
    if (s.market == StockMarket.us) {
      usTotal += s.valueTWD(rates);
    } else {
      twTotal += s.marketValue;
    }
  }
  if (usTotal > 0) result['美股'] = usTotal;
  if (twTotal > 0) result['台股'] = twTotal;

  final fundTotal =
      fundList.fold<double>(0.0, (sum, f) => sum + f.marketValue);
  if (fundTotal > 0) result['基金'] = fundTotal;

  final cryptoTotal =
      cryptoList.fold<double>(0.0, (sum, c) => sum + c.valueTWD(rates));
  if (cryptoTotal > 0) result['加密貨幣'] = cryptoTotal;

  return result;
}

@riverpod
Future<double> cashTotalTWD(CashTotalTWDRef ref) async {
  final list = ref.watch(cashAssetsProvider).valueOrNull ?? <CashAsset>[];
  if (list.isEmpty) return 0;

  final hasForeign = list.any((a) => a.currency != CurrencyCode.twd);
  if (!hasForeign) {
    return list.fold<double>(0.0, (sum, a) => sum + a.amount);
  }

  final rates = await ref.watch(allRatesToTwdProvider.future);
  return list.fold<double>(0.0, (sum, a) => sum + a.valueTWD(rates));
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

@riverpod
Future<double> cryptoTotalTWD(CryptoTotalTWDRef ref) async {
  final list = ref.watch(cryptoAssetsProvider).valueOrNull ?? <CryptoAsset>[];
  if (list.isEmpty) return 0;

  final rates = await ref.watch(allRatesToTwdProvider.future);
  return list.fold<double>(0.0, (sum, c) => sum + c.valueTWD(rates));
}
