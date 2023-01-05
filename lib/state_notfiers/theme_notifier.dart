
import 'package:flutter_riverpod/flutter_riverpod.dart';
class ThemeModeNotifier  extends StateNotifier<bool> {

  ThemeModeNotifier() : super(false){}

  toggleDark() {
    state = !state;
  }

}
