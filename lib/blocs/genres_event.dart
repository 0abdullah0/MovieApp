import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie/resources/repositery.dart';

@immutable
abstract class GenresEvent extends Equatable {
  GenresEvent([List props = const []]) : super();
}

class FetchGenres extends GenresEvent{
  final Repositery repo;
  FetchGenres(this.repo) : super([repo]);

  @override
  // TODO: implement props
  List<Object> get props => null;

}
