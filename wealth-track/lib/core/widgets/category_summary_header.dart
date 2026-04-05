import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

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

class CategorySummaryHeader extends StatelessWidget {
  final String formattedTotal;
  final Map<String, double> distribution;
  final String Function(double) formatValue;

  const CategorySummaryHeader({
    super.key,
    required this.formattedTotal,
    required this.distribution,
    required this.formatValue,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final showChart = distribution.length >= 2;

    return Card(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              '總市值',
              style: theme.textTheme.labelMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              formattedTotal,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            if (showChart) ...[
              const SizedBox(height: 16),
              _buildChart(theme),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildChart(ThemeData theme) {
    final total = distribution.values.fold(0.0, (a, b) => a + b);
    if (total == 0) return const SizedBox.shrink();

    final sorted = distribution.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final Map<String, double> displayData;
    if (sorted.length > 6) {
      displayData = Map.fromEntries(sorted.take(5));
      final othersVal = sorted.skip(5).fold(0.0, (sum, e) => sum + e.value);
      displayData['其他'] = othersVal;
    } else {
      displayData = Map.fromEntries(sorted);
    }

    final entries = displayData.entries.toList();

    return Column(
      children: [
        SizedBox(
          height: 160,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 35,
              sections: entries.asMap().entries.map((e) {
                final color = _chartColors[e.key % _chartColors.length];
                final pct = e.value.value / total * 100;
                return PieChartSectionData(
                  value: e.value.value,
                  color: color,
                  radius: 35,
                  title: pct >= 5 ? '${pct.toStringAsFixed(0)}%' : '',
                  titleStyle: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                );
              }).toList(),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 6,
          children: entries.asMap().entries.map((e) {
            final color = _chartColors[e.key % _chartColors.length];
            return Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 4),
                Text(
                  '${e.value.key}  ${formatValue(e.value.value)}',
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
