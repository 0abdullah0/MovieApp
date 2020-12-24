import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import './bloc.dart';

@immutable
class GenresBloc extends Bloc<GenresEvent, GenresState> {
  @override
  GenresState get initialState => InitialGenresState();

  @override
  Stream<GenresState> mapEventToState(
    GenresEvent event,
  ) async* {
    if(event is FetchGenres){
      final genreModel=await event.repo.fetchGenresList() ;
      yield GenresLoaded(genreModel);
    }
  }
}
