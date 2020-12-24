import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:movie/blocs/trailers_event.dart';
import './bloc.dart';

class TrailersBloc extends Bloc<TrailersEvent, TrailersState> {
  @override
  TrailersState get initialState => InitialTrailersState();

  @override
  Stream<TrailersState> mapEventToState(
    TrailersEvent event,
  ) async* {
    if(event is FetchTrailers)
      {
        final trailerModel=await event.repo.fetchAllTrailers(event.Mid);
        yield TrailerLoaded(trailerModel);
      }
  }
}
