import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie/models/genre_model.dart';

@immutable
abstract class GenresState extends Equatable {
  GenresState([List props = const []]) : super();
}

class InitialGenresState extends GenresState {
  @override
  List<Object> get props => [];
}

class GenresLoaded extends GenresState{
  final GenreModel genreModel;
  GenresLoaded(this.genreModel) : super([genreModel]);

  @override
  // TODO: implement props
  List<Object> get props => null;

}
