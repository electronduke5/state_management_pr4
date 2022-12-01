part of 'click_cubit.dart';

@immutable
abstract class ClickState {}

class ClickInitial extends ClickState {}

class ClickError extends ClickState {
  final String message;

  ClickError({
    required this.message,
  });
}

class Click extends ClickState {
  final int count;

  Click(this.count);
}
