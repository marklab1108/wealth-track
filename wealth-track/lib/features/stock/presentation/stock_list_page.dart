import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/models/asset.dart';
import '../../../core/utils/currency.dart';
import '../../../core/utils/staleness.dart';
import 'providers/stock_provider.dart';
import 'refresh_helper.dart';

class StockListPage extends ConsumerWidget {
  final bool showAppBar;
  final StockMarket market;

  const StockListPage({
    super.key,
    this.showAppBar = true,
    this.market = StockMarket.us,
  });

  bool get _isTw => market == StockMarket.tw;
  String get _title => _isTw ? '台股持倉' : '美股持倉';
  String get _emptyLabel => _isTw ? '還沒有任何台股持倉' : '還沒有任何美股持倉';
  String get _routePrefix => _isTw ? '/assets/tw-stock' : '/assets/stock';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stocksAsync = _isTw
        ? ref.watch(twStockAssetsProvider)
        : ref.watch(stockAssetsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              title: Text(_title),
              actions: [
                IconButton(
                  icon: const Icon(Icons.refresh),
                  onPressed: () => refreshAndNotify(context, ref),
                  tooltip: '刷新價格',
                ),
              ],
            )
          : null,
      body: stocksAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('載入失敗: $e')),
        data: (list) {
          if (list.isEmpty) return _buildEmpty(theme);
          return _buildList(context, list);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('$_routePrefix/add'),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmpty(ThemeData theme) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.show_chart,
            size: 64,
            color: theme.colorScheme.onSurfaceVariant.withAlpha(100),
          ),
          const SizedBox(height: 16),
          Text(
            _emptyLabel,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '點擊右下角的按鈕新增',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant.withAlpha(150),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildList(
    BuildContext context,
    List<StockAsset> list,
  ) {
    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 88),
      itemCount: list.length,
      itemBuilder: (context, i) => _StockTile(
        asset: list[i],
        routePrefix: _routePrefix,
      ),
    );
  }
}

class _StockTile extends ConsumerWidget {
  final StockAsset asset;
  final String routePrefix;

  const _StockTile({required this.asset, required this.routePrefix});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final staleness = getPriceStaleness(asset.priceUpdatedAt);
    final staleLabel = stalenessLabel(staleness);
    final returnPct = formatPercent(asset.returnRate);
    final isPositive = asset.returnRate >= 0;
    final isTw = asset.market == StockMarket.tw;
    final currencyPrefix = isTw ? 'NT\$' : '\$';

    return Dismissible(
      key: ValueKey(asset.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) async {
        return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('確認刪除'),
            content: Text('確定要刪除「${asset.name}（${asset.symbol}）」嗎？'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: const Text('取消'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(ctx, true),
                child: const Text('刪除'),
              ),
            ],
          ),
        );
      },
      onDismissed: (_) {
        ref.read(stockRepositoryProvider).deleteById(asset.id);
      },
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        color: theme.colorScheme.error,
        child: Icon(Icons.delete, color: theme.colorScheme.onError),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: theme.colorScheme.primaryContainer,
          child: Text(
            asset.symbol.length > 3
                ? asset.symbol.substring(0, 3)
                : asset.symbol,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
        ),
        title: Row(
          children: [
            Flexible(
              child: Text(
                asset.name,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (staleLabel.isNotEmpty) ...[
              const SizedBox(width: 8),
              Text(
                staleLabel,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: staleness == PriceStaleness.expired
                      ? theme.colorScheme.error
                      : theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ],
        ),
        subtitle: Text(
          '${asset.symbol} · ${asset.shares} 股 · 均價 $currencyPrefix${formatAmount(asset.avgCost)}',
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '$currencyPrefix${formatAmount(asset.currentPrice ?? asset.avgCost)}',
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            Text(
              returnPct,
              style: theme.textTheme.bodySmall?.copyWith(
                color: isPositive
                    ? const Color(0xFF2E7D32)
                    : theme.colorScheme.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        onTap: () => context.push('$routePrefix/edit/${asset.id}'),
      ),
    );
  }
}
