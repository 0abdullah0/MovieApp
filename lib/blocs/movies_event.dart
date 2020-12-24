import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/models/item_model.dart';
import '../resources/repositery.dart';

@immutable
abstract class MoviesEvent extends Equatable {
  MoviesEvent([List props = const []]) : super();
}

class FetchMovies extends MoviesEvent{
  final Repositery repo;
  FetchMovies(this.repo) : super([repo]);

  @override
  // TODO: implement props
  List<Object> get props => null;

}


