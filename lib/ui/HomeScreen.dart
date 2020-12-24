import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/blocs/bloc.dart';
import 'package:movie/blocs/movies_bloc.dart';
import 'package:movie/models/genre_model.dart';
import 'package:movie/models/item_model.dart';
import 'package:movie/resources/repositery.dart';
import 'package:movie/ui/colors.dart';
import 'package:movie/ui/movie_details.dart';

//HOME-SCREEN
class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarIconBrightness: Brightness.light
    ));
    return Scaffold(
      body:  SingleChildScrollView(
        child: Column(
            children: <Widget>[
              ContentPage(),
            ],
        ),
      ),
    );
  }
}


//CONTENT-PAGE
class ContentPage extends StatefulWidget {
  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
    Repositery repositery=Repositery();

  loadRecent(BuildContext contexts){
    final moviesBloc = BlocProvider.of<MoviesBloc>(contexts);
    moviesBloc.add(FetchMovies(repositery));
  }

    loadPopular(BuildContext contexts){
      final popularsBloc = BlocProvider.of<PopularsBloc>(contexts);
      popularsBloc.add(FetchPopular(repositery));
    }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left:20 ,top:50),
          width: MediaQuery.of(context).size.width,
          color: bgColor,
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Text('Search',style:TextStyle(
                  fontFamily: 'SubstanceMedium',
                  fontSize: 40.0,
                  color:Colors.white
              ),),
              SizedBox(height: 6.0,),
              TextField(
                style: TextStyle(color: textColor,fontSize: 24.0) ,
                decoration: InputDecoration.collapsed(
                    hintText: 'Movies,Actors,Directors....',
                    hintStyle: TextStyle(color: textColor,fontSize: 24.0),
                ),
              ),
              SizedBox(height: 12.0,),
              Container(width: MediaQuery.of(context).size.width-60,height: 0.5,color:textColor ,),
              SizedBox(height: 6.0,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 20.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Text('Recent',style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                      ),),
                    ),
                    Positioned(
                      top: 3.0,
                      right: 20.0,
                      child: Text('SEE ALL',style: TextStyle(
                        color: textColor,
                        fontSize: 18.0,
                      ),),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 12.0,),
              ///BLOC -1
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child:RecentMovies(context),
              ),
              SizedBox(height: 12.0,),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 20.0,
                child: Stack(
                  children: <Widget>[
                    Positioned(
                      child: Text('Popular',style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 22.0,
                      ),),
                    ),
                    Positioned(
                      top: 1.0,
                      right: 20.0,
                      child: Text('SEE ALL',style: TextStyle(
                        color: textColor,
                        fontSize: 18.0,
                      ),),
                    ),
                  ],
                ),
              ),
              ///BLOC -2
              Container(
                margin: EdgeInsets.only(top: 20.0),
                child:PopularMovies(context),
              ),
            ],
          ),
        )
      ],
    );
  }
  Widget stillLoading(BuildContext context){
    return CircularProgressIndicator();
  }

  Widget RecentMovies(BuildContext context){
    return BlocProvider(
      create: (context) =>MoviesBloc(),
      child: BlocListener<MoviesBloc,MoviesState>(
        listener:(BuildContext context, MoviesState state) {
          if (state is MoviesLoaded) {
            print("Loaded: ${state.itemModel.results[0].poster_path}");
          }
        },
        child:BlocBuilder<MoviesBloc,MoviesState>(
          builder: (BuildContext context, MoviesState state) {
            // Changing the UI based on the current state
            if (state is InitialMoviesState) {
              loadRecent(context);
              return stillLoading(context);
            }else if (state is MoviesLoaded) {
              return ItemLoad(state.itemModel);
            }
          },
        ) ,
      ),
    );
  }

  Widget PopularMovies(BuildContext context){
    return BlocProvider(
      create: (context) =>PopularsBloc(),
      child: BlocListener<PopularsBloc,PopularsState>(
        listener:(BuildContext context, PopularsState state) {
          if (state is  PopularLoaded) {
            print("Loaded: ${state.itemModel.results[0].poster_path}");
          }
        },
        child:BlocBuilder<PopularsBloc,PopularsState>(
          builder: (BuildContext context, PopularsState state) {
            // Changing the UI based on the current state
            if (state is InitialPopularsState) {
              loadPopular(context);
              return stillLoading(context);
            }else if (state is PopularLoaded) {
              return popularItem(state.itemModel);
            }
          },
        ) ,
      ),
    );
  }
}

//ITEM-LOAD
class ItemLoad extends StatefulWidget {
  ItemModel itemModel;
  ItemLoad(this.itemModel);
  @override
  _ItemLoadState createState() => _ItemLoadState();
}

class _ItemLoadState extends State<ItemLoad> {

  Repositery repositery=Repositery();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width-20,
      height:300.0,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (BuildContext context,int index){
          return Row(
            children: <Widget>[
              InkWell(
                onTap: (){
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>MovieDetailes(widget.itemModel.results[index])
                      )
                  );
                },
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 300.0,
                    minHeight: 300.0,
                    maxWidth: MediaQuery.of(context).size.width*0.40,
                    minWidth: MediaQuery.of(context).size.width*0.40,
                  ),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius:BorderRadius.circular(20.0) ,
                        child: Image.network(widget.itemModel.results[index].poster_path,fit: BoxFit.cover,),
                      ),
                      SizedBox(height: 4.0,),
                      Text(
                        widget.itemModel.results[index].title,
                        style: TextStyle(
                          color: Colors.white,
                        ),),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 20.0,),
            ],
          );
        },
      ),
    );
  }
}

class popularItem extends StatefulWidget {
  ItemModel itemModel;
  popularItem(this.itemModel);

  @override
  _popularItemState createState() => _popularItemState();
}

class _popularItemState extends State<popularItem> {
  Repositery repositery=Repositery();

  loadGenre(BuildContext contexts){
    final genresBloc = BlocProvider.of<GenresBloc>(contexts);
    genresBloc.add(FetchGenres(repositery));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width-20,
      height: MediaQuery.of(context).size.height-500,
      child: ListView.builder(
        padding: EdgeInsets.only(top: 10.0),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: 4,
        itemBuilder: (BuildContext context,int index){
          return Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Container(
                      width: 180,
                      height: 200,
                      child:  ClipRRect(
                        borderRadius:BorderRadius.circular(20.0) ,
                        child: Image.network(widget.itemModel.results[index].poster_path,fit: BoxFit.cover,),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 30.0,bottom: 30.0,right: 10.0,left: 10.0),
                      child: Container(
                        width: 180,
                        height: 150,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(widget.itemModel.results[index].title,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                            SizedBox(height: 8.0,),
                            Text(widget.itemModel.results[index].release_date,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.0,
                              ),
                            ),
                            SizedBox(height: 8.0,),
                            GenresMovies(context,index,widget.itemModel.results[index].genre_ids),
                            Row(
                              children: <Widget>[
                                Icon(Icons.star,color: iconColor,size: 26.0,),
                                RichText(
                                    text: TextSpan(
                                      text: widget.itemModel.results[index].vote_avg,
                                      style:TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 18.0),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "/10",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    )
                                ),
                              ],
                            )
                          ],
                        )
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
  Widget GenresMovies(BuildContext context,int index,List<int> ids){
    return BlocProvider(
      create: (context) =>GenresBloc(),
      child: BlocListener<GenresBloc,GenresState>(
        listener:(BuildContext context, GenresState state) {
          if (state is  GenresLoaded) {
            print("Loaded: genres}");
          }
        },
        child:BlocBuilder<GenresBloc,GenresState>(
          builder: (BuildContext context, GenresState state) {
            // Changing the UI based on the current state
            if (state is InitialGenresState) {
              loadGenre(context);
              return CircularProgressIndicator();
            }else if (state is GenresLoaded) {
              return Text(state.genreModel.getGenre(ids),
                style:TextStyle(
                  color: textColor,
                  fontSize: 16.0
              ),
              );
            }
          },
        ) ,
      ),
    );
  }
}




