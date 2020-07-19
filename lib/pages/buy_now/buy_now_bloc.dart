import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'buy_now_event.dart';

part 'buy_now_state.dart';

class BuyNowBloc extends Bloc<BuyNowEvent, BuyNowState> {
  BuyNowBloc(BuyNowState initialState) : super(initialState);


  @override
  Stream<BuyNowState> mapEventToState(BuyNowEvent event) async* {
    // TODO: Add your event logic
  }
}
