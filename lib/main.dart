import 'package:flutter/material.dart';
import 'package:word_game/core/get_it/get_it.dart';
import 'package:word_game/core/router/app_router.dart';
import 'package:word_game/core/theme/app_theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
  runApp(MaterialApp.router(
    debugShowCheckedModeBanner: false,
    routerConfig: AppRouter.router,
    theme: AppTheme.getTheme(),
  ));
}