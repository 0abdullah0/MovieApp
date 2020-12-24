import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class PopularsBloc extends Bloc<PopularsEvent, PopularsState> {
  @override
  PopularsState get initialState => InitialPopularsState();

  @override
  Stream<PopularsState> mapEventToState(
    PopularsEvent event,
  ) async* {
    if(event is FetchPopular){
      final itemModel=await event.repo.fetchPopularList(false) ;
      yield PopularLoaded(itemModel);
    }
  }
}
