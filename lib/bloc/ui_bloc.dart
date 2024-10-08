import 'package:bloc/bloc.dart';
import 'dart:async';
import 'package:meta/meta.dart';
import '../pages/ui_overview_screen.dart';
part 'ui_event.dart';
part 'ui_state.dart';

class UIBloc extends Bloc<UIEvent, UIState> {
  UIBloc() : super(UIInitial()){
    on<onUIEventCalled>((event, emit) async {
      print('onUIEventCalled event received');
      emit(UILoading());
      await Future.delayed(Duration(seconds: 2));
      print('Loading complete, emitting UILoaded');
      emit(UILoaded(UIOverviewScreen()));
    });
  }
}