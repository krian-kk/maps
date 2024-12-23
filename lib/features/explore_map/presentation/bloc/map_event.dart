import 'package:equatable/equatable.dart';

abstract class MapEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadMarkersEvent extends MapEvent {}

class FilterMarkersEvent extends MapEvent {
  final String category;

  FilterMarkersEvent(this.category);

  @override
  List<Object> get props => [category];
}

class ToggleDarkModeEvent extends MapEvent {}

