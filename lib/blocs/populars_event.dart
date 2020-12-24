import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie/resources/repositery.dart';

@immutable
abstract class PopularsEvent extends Equatable {
  PopularsEvent([List props = const []]) : super();
}


class FetchPopular extends PopularsEvent{
  final Repositery repo;
  FetchPopular(this.repo) : super([repo]);

  @override
  // TODO: implement props
  List<Object> get props => null;

}