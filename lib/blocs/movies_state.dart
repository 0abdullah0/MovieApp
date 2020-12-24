import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/models/item_model.dart';

@immutable
abstract class MoviesState extends Equatable  {
    MoviesState([List props = const []]) : super();
}

class InitialMoviesState extends MoviesState {
  @override
  // TODO: implement props
  List<Object> get props => null;
}

class MoviesLoaded extends MoviesState{
  final ItemModel itemModel;
  MoviesLoaded(this.itemModel) : super([itemModel]);

  @override
  // TODO: implement props
  List<Object> get props => null;
}
