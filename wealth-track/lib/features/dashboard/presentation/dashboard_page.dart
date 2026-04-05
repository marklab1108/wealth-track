import 'package:flutter/material.dart';

import 'widgets/allocation_pie_chart.dart';
import 'widgets/total_value_card.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WealthTrack')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          TotalValueCard(),
          SizedBox(height: 16),
          AllocationPieChart(),
        ],
      ),
    );
  }
}
