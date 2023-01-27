import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'models/nba_model.dart';

part 'nba_event.dart';
part 'nba_state.dart';

class NbaBloc extends Bloc<NbaEvent, NbaState> {
  NbaBloc() : super(NbaInitial()) {
    on<LoadNbaCounter>((event, emit) async {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(NbaLoaded(nbas: <Nba> []));
    });

    on<AddNba>((event, emit) async {
      if (state is NbaLoaded) {
        final state = this.state as NbaLoaded;
        emit(
          NbaLoaded(nbas: List.from(state.nbas)..add(event.nba)
        ));
      }  

    });

    on<RemoveNba>((event, emit) async {
      if (state is NbaLoaded) {
        final state = this.state as NbaLoaded;
        emit(
          NbaLoaded(nbas: List.from(state.nbas)..remove(event.nba)
        ));
      }  
    });
  }
}
