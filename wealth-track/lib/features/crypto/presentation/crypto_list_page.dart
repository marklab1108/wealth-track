import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/models/asset.dart';
import '../../../core/utils/currency.dart';
import '../../../core/utils/staleness.dart';
import '../../../core/widgets/category_summary_header.dart';
import 'providers/crypto_provider.dart';

class CryptoListPage extends ConsumerWidget {
  final bool showAppBar;

  const CryptoListPage({super.key, this.showAppBar = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cryptoAsync = ref.watch(cryptoAssetsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: showAppBar ? AppBar(title: const Text('加密貨幣持倉')) : null,
      body: cryptoAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('載入失敗: $e')),
        data: (list) {
          if (list.isEmpty) return _buildEmpty(theme);
          return _buildList(context, list);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/assets/crypto/add'),
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
            Icons.currency_bitcoin,
            size: 64,
            color: theme.colorScheme.onSurfaceVariant.withAlpha(100),
          ),
          const SizedBox(height: 16),
          Text(
            '還沒有任何加密貨幣',
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

  Widget _buildList(BuildContext context, List<CryptoAsset> list) {
    final total = list.fold<double>(0.0, (sum, c) => sum + c.marketValue);
    final distribution = <String, double>{};
    for (final c in list) {
      distribution[c.name] = (distribution[c.name] ?? 0) + c.marketValue;
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 88),
      itemCount: list.length + 1,
      itemBuilder: (context, i) {
        if (i == 0) {
          return CategorySummaryHeader(
            formattedTotal: '\$${formatAmount(total)}',
            distribution: distribution,
            formatValue: (v) => '\$${formatAmount(v)}',
          );
        }
        return _CryptoTile(asset: list[i - 1]);
      },
    );
  }
}

class _CryptoTile extends ConsumerWidget {
  final CryptoAsset asset;

  const _CryptoTile({required this.asset});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final staleness = getPriceStaleness(asset.priceUpdatedAt);
    final staleLabel = stalenessLabel(staleness);
    final returnPct = formatPercent(asset.returnRate);
    final isPositive = asset.returnRate >= 0;

    final subtitleParts = [
      asset.symbol,
      formatAmount(asset.amount),
      '均價 \$${formatAmount(asset.avgCost)}',
    ];
    if (asset.currentPrice != null) {
      subtitleParts.add('現 \$${formatAmount(asset.currentPrice!)}');
    }

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
        ref.read(cryptoRepositoryProvider).deleteById(asset.id);
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
              child: Text(asset.name, overflow: TextOverflow.ellipsis),
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
        subtitle: Text(subtitleParts.join(' · ')),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '\$${formatAmount(asset.marketValue)}',
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
        onTap: () => context.push('/assets/crypto/edit/${asset.id}'),
      ),
    );
  }
}
