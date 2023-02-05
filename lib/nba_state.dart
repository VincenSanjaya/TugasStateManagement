part of 'nba_bloc.dart';

@immutable
abstract class NbaState {}

class NbaInitial extends NbaState {}

 class NbaLoaded extends NbaState {
  final List<Nba> nbas;

  NbaLoaded({required this.nbas});

  @override
   List<Object> get props => [nbas];
 }
