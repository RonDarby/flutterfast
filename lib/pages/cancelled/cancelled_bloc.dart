import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'cancelled_event.dart';

part 'cancelled_state.dart';

class CancelledBloc extends Bloc<CancelledEvent, CancelledState> {
  CancelledBloc() : super(InitialCancelledState());

  @override
  Stream<CancelledState> mapEventToState(CancelledEvent event) async* {
    // TODO: Add your event logic
  }
}
