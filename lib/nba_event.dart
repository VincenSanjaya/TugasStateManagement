part of 'nba_bloc.dart';

abstract class NbaEvent extends Equatable {
  const NbaEvent();

  @override
  List<Object> get props => [];
}

class LoadNbaCounter extends NbaEvent {}

class AddNba extends NbaEvent {
  final Nba nba;

  const AddNba(this.nba);

  @override
  List<Object> get props => [nba];

}

class RemoveNba extends NbaEvent {
  final Nba nba;

  const RemoveNba(this.nba);

  @override
  List<Object> get props => [nba];
}