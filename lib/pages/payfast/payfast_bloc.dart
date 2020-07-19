import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'payfast_event.dart';

part 'payfast_state.dart';

class PayfastBloc extends Bloc<PayfastEvent, PayfastState> {
  PayfastBloc() : super(InitialPayfastState());

  @override
  Stream<PayfastState> mapEventToState(PayfastEvent event) async* {
    // TODO: Add your event logic
  }
}
