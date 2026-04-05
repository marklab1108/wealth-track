import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../cash/presentation/cash_list_page.dart';
import '../../stock/presentation/refresh_helper.dart';
import '../../stock/presentation/stock_list_page.dart';

class AssetsTabPage extends ConsumerStatefulWidget {
  const AssetsTabPage({super.key});

  @override
  ConsumerState<AssetsTabPage> createState() => _AssetsTabPageState();
}

class _AssetsTabPageState extends ConsumerState<AssetsTabPage>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isStockTab = _tabController.index == 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('資產'),
        actions: [
          if (isStockTab)
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: '刷新價格',
              onPressed: () => refreshAndNotify(context, ref),
            ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: '現金'),
            Tab(text: '美股'),
          ],
          labelColor: theme.colorScheme.primary,
          indicatorColor: theme.colorScheme.primary,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          CashListPage(showAppBar: false),
          StockListPage(showAppBar: false),
        ],
      ),
    );
  }
}
