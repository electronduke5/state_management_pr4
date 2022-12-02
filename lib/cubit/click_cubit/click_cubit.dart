import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management_pr4/cubit/theme_cubit/theme_cubit.dart';

part 'click_state.dart';

class ClickCubit extends Cubit<ClickState> {
  ClickCubit() : super(ClickInitial());
  int count = 0;
  List<String> widgetsList = <String>[];
  static const String _textMessage = 'Counter equals 10!';

  void onIncClick(ThemeMode theme) {
    theme == ThemeMode.light ? count++ : count += 2;
    if (count == 10) {
      emit(ClickError(message: _textMessage));
      widgetsList.add(_textMessage);
      count = 0;
      return;
    }
    emit(Click(count));
    widgetsList
        .add('Counter = ${count.toString()}, current theme is ${theme.name}');
  }

  void onDecClick(ThemeMode theme) {
    theme == ThemeMode.light ? count-- : count += -2;
    if (count == 10) {
      emit(ClickError(message: _textMessage));
      widgetsList.add(_textMessage);
      count = 0;
      return;
    }
    widgetsList
        .add('Counter = ${count.toString()}, current theme is ${theme.name}');
    emit(Click(count));
  }

  void getThemeName(BuildContext context) {
    widgetsList.add(
        'Theme was switched on ${context.read<ThemeCubit>().themeMode.name}');
  }

  void clearLog() {
    widgetsList.clear();
    emit(ClickError(message: count.toString()));
  }
}
