
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:protibeshi_app/state_notfiers/theme_notifier.dart';

final themeProvider = StateNotifierProvider.autoDispose<ThemeModeNotifier, bool>(
        (ref) =>  ThemeModeNotifier());
