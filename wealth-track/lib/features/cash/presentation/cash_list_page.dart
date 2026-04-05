import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/models/asset.dart';
import '../../../core/utils/currency.dart';
import 'providers/cash_provider.dart';

class CashListPage extends ConsumerWidget {
  const CashListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cashAsync = ref.watch(cashAssetsProvider);
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('現金資產')),
      body: cashAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('載入失敗: $e')),
        data: (list) {
          if (list.isEmpty) return _buildEmpty(theme);
          return _buildList(context, ref, list, theme);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/assets/cash/add'),
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
            Icons.account_balance_outlined,
            size: 64,
            color: theme.colorScheme.onSurfaceVariant.withAlpha(100),
          ),
          const SizedBox(height: 16),
          Text(
            '還沒有任何現金資產',
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
    WidgetRef ref,
    List<CashAsset> list,
    ThemeData theme,
  ) {
    final grouped = <String, List<CashAsset>>{};
    for (final a in list) {
      grouped.putIfAbsent(a.bankName, () => []).add(a);
    }

    final banks = grouped.keys.toList()..sort();

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 88),
      itemCount: banks.length,
      itemBuilder: (context, i) {
        final bank = banks[i];
        final items = grouped[bank]!;
        final bankTotal = items.fold(0.0, (sum, a) => sum + a.amount);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 4),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      bank,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Text(
                    formatTWD(bankTotal),
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            ...items.map((a) => _CashTile(asset: a)),
          ],
        );
      },
    );
  }
}

class _CashTile extends ConsumerWidget {
  final CashAsset asset;

  const _CashTile({required this.asset});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Dismissible(
      key: ValueKey(asset.id),
      direction: DismissDirection.endToStart,
      confirmDismiss: (_) async {
        return await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('確認刪除'),
            content: Text('確定要刪除「${asset.name}」嗎？'),
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
        ref.read(cashRepositoryProvider).deleteById(asset.id);
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
            asset.currency.label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: theme.colorScheme.onPrimaryContainer,
            ),
          ),
        ),
        title: Text(asset.name),
        subtitle: Text(asset.currency.label),
        trailing: Text(
          '${asset.currency.symbol} ${formatAmount(asset.amount)}',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        onTap: () => context.push('/assets/cash/edit/${asset.id}'),
      ),
    );
  }
}
