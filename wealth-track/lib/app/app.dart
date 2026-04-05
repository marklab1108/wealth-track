import 'package:flutter/material.dart';
import 'router.dart';
import 'theme.dart';

class WealthTrackApp extends StatelessWidget {
  const WealthTrackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'WealthTrack',
      theme: AppTheme.light,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
