import 'package:flutter/cupertino.dart';

class GenreModel{
  List<Result> results= [];

  GenreModel.fromJson(Map<String,dynamic> pasre){
    List<Result> temp= [];
    for(var i=0;i<pasre['genres'].length;++i){
      Result result=Result(pasre['genres'][i]);
      temp.add(result);
    }
    results=temp;
  }

  List<Result> get get_genres => results;

  String  getGenre(List<int> ids){
    ids=ids.toSet().toList();
    String mygenre="";
    for(var i=0;i<ids.length;++i){
      mygenre+=results.where((user) => user.id == ids[i]).first.name+", ";
    }

    mygenre=mygenre.substring(0,mygenre.length-2);
    return mygenre;
  }

}

class Result{
  int id;
  String name;

  Result(result){
    id=result['id'];
    name=result['name'].toString();
  }

  int get get_id => id;
  String get  get_name => name;

}