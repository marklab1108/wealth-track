import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/utils/currency.dart';
import '../../stock/presentation/refresh_helper.dart';
import 'providers/dashboard_provider.dart';
import 'widgets/allocation_pie_chart.dart';
import 'widgets/total_value_card.dart';

class DashboardPage extends ConsumerWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cashTotal = ref.watch(cashTotalValueProvider);
    final stockTotalAsync = ref.watch(stockTotalValueTWDProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('WealthTrack'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: '刷新價格',
            onPressed: () => refreshAndNotify(context, ref),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const TotalValueCard(),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '資產明細',
                    style: theme.textTheme.titleSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _AssetRow(
                    icon: Icons.account_balance,
                    label: '現金',
                    value: cashTotal,
                    color: const Color(0xFF2E7D32),
                  ),
                  stockTotalAsync.when(
                    loading: () => _AssetRow(
                      icon: Icons.show_chart,
                      label: '美股',
                      value: 0,
                      color: const Color(0xFF1565C0),
                      trailing: const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                    error: (_, _) => _AssetRow(
                      icon: Icons.show_chart,
                      label: '美股',
                      value: 0,
                      color: const Color(0xFF1565C0),
                    ),
                    data: (v) => _AssetRow(
                      icon: Icons.show_chart,
                      label: '美股',
                      value: v,
                      color: const Color(0xFF1565C0),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const AllocationPieChart(),
        ],
      ),
    );
  }
}

class _AssetRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final double value;
  final Color color;
  final Widget? trailing;

  const _AssetRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: color.withAlpha(30),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: theme.textTheme.bodyMedium)),
          trailing ??
              Text(
                formatTWD(value),
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
        ],
      ),
    );
  }
}
