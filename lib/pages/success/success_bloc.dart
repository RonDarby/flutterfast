import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'success_event.dart';

part 'success_state.dart';

class SuccessBloc extends Bloc<SuccessEvent, SuccessState> {
  SuccessBloc() : super(InitialSuccessState());


  @override
  Stream<SuccessState> mapEventToState(SuccessEvent event) async* {
    // TODO: Add your event logic
  }
}
