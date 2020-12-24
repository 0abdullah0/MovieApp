import 'package:flutter/cupertino.dart';

class ItemModel{
  int page;
  int total_page;
  int total_results;
  List<Result> results= [];

  ItemModel.fromJson(Map<String,dynamic> pasre,bool isRecent){
    page=pasre['page'];
    total_results=pasre['total_results'];
    total_page=pasre['total_page'];
    List<Result> temp= [];
    for(var i=0;i<pasre['results'].length;++i){
      Result result=Result(pasre['results'][i]);
      temp.add(result);
    }

    if(!isRecent)
      temp.sort((a,b){
        return b.popularity.toString().compareTo(a.popularity.toString());
      });
    else
      temp.sort((a,b){
        return DateTime.parse(b.release_date).compareTo(DateTime.parse(a.release_date));
      });
    results=temp;
  }
}

class Result{
  String vote_count;
  int id;
  bool video;
  String title;
  var vote_avg;
  double popularity;
  String poster_path;
  List<int> genre_ids=[];
  String backdrop_path;
  bool adult;
  String overview;
  String release_date;

  Result(result){
    vote_count=result['vote_count'].toString();
    id=result['id'];
    title=result['title'];
    video=result['video'];
    vote_avg=result['vote_average'].toString();
    poster_path="http://image.tmdb.org/t/p/w185/"+result['poster_path'].toString();
    for(var i=0;i<result['genre_ids'].length;++i){
      genre_ids.add(result['genre_ids'][i]);
    }
    backdrop_path=result['backdrop_path'].toString();
    adult=result['adult'];
    overview=result['overview'];
    release_date=result['release_date'].toString();
    popularity=result['popularity'];
  }

  String get  get_release_date => release_date;
  String get  get_overview => overview;
  bool get  get_adult => adult;
  String get  get_backdrop_path => backdrop_path;
  List<int> get  get_genre_ids => genre_ids;
  String get  get_poster_path => poster_path;
  double get  get_popularity => popularity;
  String get  get_vote_avg => vote_avg;
  String get  get_vote_count=> vote_count;
  bool get is_video => video;
  int get get_id => id;
  String get  get_title => title;





}