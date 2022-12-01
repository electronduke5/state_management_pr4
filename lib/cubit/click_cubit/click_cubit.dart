import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:state_management_pr4/cubit/theme_cubit/theme_cubit.dart';

part 'click_state.dart';

class ClickCubit extends Cubit<ClickState> {
  ClickCubit() : super(ClickInitial());
  int count = 0;
  List<String> widgetsList = <String>[];

  void onIncClick() {
    count++;
    if (count == 10) {
      emit(ClickError(message: 'Счетчик равен 10!'));
      widgetsList.add('Счетчик равен 10!');
      count = 0;
      return;
    }
    emit(Click(count));
    widgetsList.add(count.toString());
  }

  void onDecClick() {
    count--;
    if (count == 10) {
      emit(ClickError(message: 'Счетчик равен 10!'));
      widgetsList.add('Счетчик равен 10!');
      count = 0;
      return;
    }
    widgetsList.add(count.toString());
    emit(Click(count));
  }

  void getThemeName(BuildContext context) {
    widgetsList
        .add('Текущая тема: ${context.read<ThemeCubit>().themeMode.name}');
  }

  void clearLog() {
    widgetsList.clear();
    emit(ClickError(message: count.toString()));
  }
}
