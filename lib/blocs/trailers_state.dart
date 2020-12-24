import 'package:equatable/equatable.dart';
import 'package:movie/models/trailer_model.dart';

abstract class TrailersState extends Equatable {
  TrailersState([List props = const []]) : super();
}

class InitialTrailersState extends TrailersState {
  @override
  List<Object> get props => [];
}

class TrailerLoaded extends TrailersState{
  final TrailerModel trailerModel;
  TrailerLoaded(this.trailerModel) : super([trailerModel]);

  @override
  // TODO: implement props
  List<Object> get props => null;
}
