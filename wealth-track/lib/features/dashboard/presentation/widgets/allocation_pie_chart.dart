import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/utils/currency.dart';
import '../providers/dashboard_provider.dart';

const _chartColors = [
  Color(0xFF2E7D32),
  Color(0xFF1565C0),
  Color(0xFFEF6C00),
  Color(0xFF6A1B9A),
  Color(0xFFC62828),
  Color(0xFF00838F),
  Color(0xFF4E342E),
  Color(0xFF37474F),
];

class AllocationPieChart extends ConsumerWidget {
  const AllocationPieChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(assetAllocationProvider);
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Text(
              '資產分布',
              style: theme.textTheme.titleSmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),
            if (data.isEmpty)
              SizedBox(
                height: 200,
                child: Center(
                  child: Text(
                    '新增你的第一筆資產',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              )
            else
              _buildChart(data, theme),
          ],
        ),
      ),
    );
  }

  Widget _buildChart(Map<String, double> data, ThemeData theme) {
    final total = data.values.fold(0.0, (a, b) => a + b);
    final entries = data.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Column(
      children: [
        SizedBox(
          height: 200,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 50,
              sections: entries.asMap().entries.map((e) {
                final color = _chartColors[e.key % _chartColors.length];
                final pct = e.value.value / total * 100;
                return PieChartSectionData(
                  value: e.value.value,
                  color: color,
                  radius: 40,
                  title: pct >= 5 ? '${pct.toStringAsFixed(0)}%' : '',
                  titleStyle: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 16,
          runSpacing: 8,
          children: entries.asMap().entries.map((e) {
            final color = _chartColors[e.key % _chartColors.length];
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(3),
                  ),
                ),
                const SizedBox(width: 6),
                Text(
                  '${e.value.key}  ${formatTWD(e.value.value)}',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
