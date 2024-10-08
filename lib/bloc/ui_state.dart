part of 'ui_bloc.dart';

@immutable
abstract class UIState {}

class UIInitial extends UIState {}
class UILoading extends UIState {}
class UILoaded extends UIState {
  final UIOverviewScreen result;
  UILoaded(this.result);
}


