import 'package:equatable/equatable.dart';
import 'package:movie/resources/repositery.dart';

abstract class TrailersEvent extends Equatable {
  TrailersEvent([List props = const []]) : super();
}

class FetchTrailers extends TrailersEvent{
  final Repositery repo;
  final int Mid;
  FetchTrailers(this.repo,this.Mid) : super([repo,Mid]);

  @override
  // TODO: implement props
  List<Object> get props => null;

}
