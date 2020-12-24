import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import './bloc.dart';
import '../resources/repositery.dart';


class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  @override
  MoviesState get initialState => InitialMoviesState();

  @override
  Stream<MoviesState> mapEventToState(
    MoviesEvent event,
  ) async* {
    if(event is FetchMovies){
      final itemModel=await event.repo.fetchMovieList(true) ;
      yield MoviesLoaded(itemModel);
    }
  }
}
