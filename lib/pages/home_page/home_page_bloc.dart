import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'home_page_event.dart';

part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(InitialHomePageState());


  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {
    // TODO: Add your event logic
  }
}
