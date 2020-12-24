import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:movie/models/item_model.dart';

@immutable
abstract class PopularsState extends Equatable {
  PopularsState([List props = const []]) : super();
}

class InitialPopularsState extends PopularsState {
  @override
  List<Object> get props => null;
}

class PopularLoaded extends PopularsState{
  final ItemModel itemModel;
  PopularLoaded(this.itemModel) : super([itemModel]);

  @override
  // TODO: implement props
  List<Object> get props => null;
}
