import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:movie/models/genre_model.dart';
import 'package:movie/models/trailer_model.dart';
import '../models/item_model.dart';
import 'package:http/http.dart' show Client ;

class Repositery{

  Client client=new Client();
  final apiKey="ddb97987d2852e92296ad615efcf7b97";
  final baseUrl="https://api.themoviedb.org/3/movie";

  Future<ItemModel> fetchMovieList(bool flag)async{
    debugPrint("entered recent");
    final response= await client.get("${baseUrl}/now_playing?api_key=${apiKey}");
    if(response.statusCode==200){
      return ItemModel.fromJson(json.decode(response.body),flag) ;
    }else{
      throw Exception('Failed to load post');
    }
  }

  Future<ItemModel> fetchPopularList(bool flag)async{
    debugPrint("entered popular");
    final response= await client.get("${baseUrl}/popular?api_key=${apiKey}");
    if(response.statusCode==200){
      return ItemModel.fromJson(json.decode(response.body),flag) ;
    }else{
      throw Exception('Failed to load post');
    }
  }

  Future<GenreModel> fetchGenresList()async{
    debugPrint("entered genres");
    final response= await client.get("https://api.themoviedb.org/3/genre/movie/list?api_key=${apiKey}");
    if(response.statusCode==200){
      return GenreModel.fromJson(json.decode(response.body)) ;
    }else{
      throw Exception('Failed to load post');
    }
  }

  Future<TrailerModel> fetchAllTrailers(int movieId)async{
    debugPrint("entered trailers");
    final response= await client.get("https://api.themoviedb.org/3/movie/${movieId.toString()}/videos?api_key=${apiKey}");
    if(response.statusCode==200){
      return TrailerModel.fromJson(json.decode(response.body)) ;
    }else{
      throw Exception('Failed to load post');
    }
  }


}