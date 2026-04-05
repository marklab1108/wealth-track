import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../crypto/presentation/providers/crypto_provider.dart';
import '../../fund/presentation/providers/fund_provider.dart';
import 'providers/stock_provider.dart';

Future<void> refreshAndNotify(BuildContext context, WidgetRef ref) async {
  try {
    ref.invalidate(refreshStockPricesProvider);
    ref.invalidate(refreshCryptoPricesProvider);
    ref.invalidate(refreshFundPricesProvider);

    final results = await Future.wait([
      ref.read(refreshStockPricesProvider.future),
      ref.read(refreshCryptoPricesProvider.future),
      ref.read(refreshFundPricesProvider.future),
    ]);

    final totalUpdated =
        results.fold<int>(0, (sum, r) => sum + r.updated);
    final totalRequested =
        results.fold<int>(0, (sum, r) => sum + r.requested);
    final allFailed =
        results.expand<String>((r) => r.failed).toList();

    if (!context.mounted) return;

    final String message;
    if (totalRequested == 0) {
      message = '所有價格皆為最新';
    } else if (allFailed.isNotEmpty && totalUpdated == 0) {
      message = '找不到以下代號：${allFailed.join(", ")}\n請確認代號是否正確';
    } else if (allFailed.isNotEmpty) {
      message = '已更新 $totalUpdated 支，找不到：${allFailed.join(", ")}';
    } else {
      message = '已更新 $totalUpdated 支價格';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: allFailed.isNotEmpty ? 4 : 2),
      ),
    );
  } catch (e) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('價格更新失敗: $e')),
      );
    }
  }
}
