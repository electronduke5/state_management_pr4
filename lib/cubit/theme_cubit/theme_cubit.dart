import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(LightThemeState());
  ThemeMode themeMode = ThemeMode.light;

  void switchTheme() {
    if (themeMode == ThemeMode.light) {
      themeMode = ThemeMode.dark;
      emit(DarkThemeState());
    } else {
      themeMode = ThemeMode.light;
      emit(LightThemeState());
    }
  }
}
