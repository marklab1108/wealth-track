import 'package:go_router/go_router.dart';

import '../features/cash/presentation/cash_form_page.dart';
import '../features/cash/presentation/cash_list_page.dart';
import '../features/dashboard/presentation/dashboard_page.dart';
import '../features/settings/presentation/settings_page.dart';
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
              builder: (context, state) => const CashListPage(),
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
