import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'providers/stock_provider.dart';

Future<void> refreshAndNotify(BuildContext context, WidgetRef ref) async {
  try {
    ref.invalidate(refreshStockPricesProvider);
    final result = await ref.read(refreshStockPricesProvider.future);

    if (!context.mounted) return;

    final String message;
    if (result.requested == 0) {
      message = '所有價格皆為最新';
    } else if (result.failed.isNotEmpty && result.updated == 0) {
      message = '找不到以下代號：${result.failed.join(", ")}\n請確認股票代號是否正確';
    } else if (result.failed.isNotEmpty) {
      message =
          '已更新 ${result.updated} 支，找不到：${result.failed.join(", ")}';
    } else {
      message = '已更新 ${result.updated} 支股票價格';
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: result.failed.isNotEmpty ? 4 : 2),
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
