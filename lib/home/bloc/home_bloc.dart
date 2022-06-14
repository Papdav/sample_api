import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../services/boredServices.dart';
import '../../services/connectivityServices.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BoredService _service;
  final ConnectivityServices _connectivityServices;

  HomeBloc(this._service, this._connectivityServices) : super(HomeLoadingState()) {

    _connectivityServices.connectivityStream.stream.listen((event) {
      if(event == ConnectivityResult.none){
        print('No Internet');
        add(NoInternetEvent());
      }else{
        print('Yes Internet');
        add(LoadApiEvent());
      }
    });

    on<LoadApiEvent>((event, emit) async{
      emit(HomeLoadingState());
      final activity = await _service.getBoredActivity();
      emit(HomeLoadedState(activity.activity, activity.type, activity.participants));
    });

    on<NoInternetEvent>((event,emit){
      emit(HomeNoInternetState());
    });
  }
}
