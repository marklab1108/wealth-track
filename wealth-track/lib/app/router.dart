import 'package:go_router/go_router.dart';

import '../core/models/asset.dart';
import '../features/cash/presentation/cash_form_page.dart';
import '../features/crypto/presentation/crypto_form_page.dart';
import '../features/dashboard/presentation/assets_tab_page.dart';
import '../features/dashboard/presentation/dashboard_page.dart';
import '../features/fund/presentation/fund_form_page.dart';
import '../features/settings/presentation/settings_page.dart';
import '../features/stock/presentation/stock_form_page.dart';
import 'shell_page.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ShellPage(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const DashboardPage(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/assets',
              builder: (context, state) => const AssetsTabPage(),
              routes: [
                GoRoute(
                  path: 'cash/add',
                  builder: (context, state) => const CashFormPage(),
                ),
                GoRoute(
                  path: 'cash/edit/:id',
                  builder: (context, state) => CashFormPage(
                    editId: state.pathParameters['id'],
                  ),
                ),
                GoRoute(
                  path: 'stock/add',
                  builder: (context, state) => const StockFormPage(),
                ),
                GoRoute(
                  path: 'stock/edit/:id',
                  builder: (context, state) => StockFormPage(
                    editId: state.pathParameters['id'],
                  ),
                ),
                GoRoute(
                  path: 'tw-stock/add',
                  builder: (context, state) =>
                      const StockFormPage(market: StockMarket.tw),
                ),
                GoRoute(
                  path: 'tw-stock/edit/:id',
                  builder: (context, state) => StockFormPage(
                    editId: state.pathParameters['id'],
                    market: StockMarket.tw,
                  ),
                ),
                GoRoute(
                  path: 'fund/add',
                  builder: (context, state) => const FundFormPage(),
                ),
                GoRoute(
                  path: 'fund/edit/:id',
                  builder: (context, state) => FundFormPage(
                    editId: state.pathParameters['id'],
                  ),
                ),
                GoRoute(
                  path: 'crypto/add',
                  builder: (context, state) => const CryptoFormPage(),
                ),
                GoRoute(
                  path: 'crypto/edit/:id',
                  builder: (context, state) => CryptoFormPage(
                    editId: state.pathParameters['id'],
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/settings',
              builder: (context, state) => const SettingsPage(),
            ),
          ],
        ),
      ],
    ),
  ],
);
