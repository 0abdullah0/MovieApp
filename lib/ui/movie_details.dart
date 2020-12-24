import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/blocs/bloc.dart';
import 'package:movie/blocs/genres_bloc.dart';
import 'package:movie/blocs/genres_event.dart';
import 'package:movie/blocs/genres_state.dart';
import 'package:movie/blocs/trailers_bloc.dart';
import 'package:movie/blocs/trailers_state.dart';
import 'package:movie/models/item_model.dart';
import 'package:movie/models/trailer_model.dart';
import 'package:movie/resources/repositery.dart';
import 'package:movie/resources/repositery.dart';
import 'package:movie/resources/repositery.dart';
import 'package:movie/resources/repositery.dart';
import 'package:movie/ui/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class MovieDetailes extends StatefulWidget {
  Result data;
  MovieDetailes(this.data);
  @override
  _MovieDetailesState createState() => _MovieDetailesState();
}

class _MovieDetailesState extends State<MovieDetailes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Content(widget.data),
    );
  }
}

_launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

class Content extends StatefulWidget {
  Result data;
  Content(this.data);
  @override
  _ContentState createState() => _ContentState();
}

class _ContentState extends State<Content> {

  @override
  Widget build(BuildContext context) {
    double _width=MediaQuery.of(context).size.width;
    return Container(
      width: _width,
      height: MediaQuery.of(context).size.height,
      color: bgColor,
      child:Stack(
        children: <Widget>[
          Container(
            height: 360,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(widget.data.poster_path.replaceAll("w185", "w400")),
                fit: BoxFit.fitWidth,
                alignment: FractionalOffset.topCenter
              )
            ),
            ),
          Positioned(
            top:50 ,
              left: 20,
              child: InkWell(
                onTap: ()=>Navigator.pop(context),
                child: Icon(
                  Icons.arrow_back_ios,
                  color:Colors.white,
                ),
              )
          ),
          Positioned(
              top:50 ,
              right: 20,
              child: InkWell(
                onTap: ()=>debugPrint("sqlite"),
                child: Icon(
                  Icons.favorite_border,
                  color:Colors.white,
                ),
              )
          ),
          Positioned(
            top: 300,
            child: Container(
              padding: EdgeInsets.only(left:20.0 ,top: 8.0),
              width: _width,
              height: 80.0,
              decoration:BoxDecoration(
                gradient: LinearGradient(
                stops: [0.1,0.3,0.5,0.7,0.9],
                colors:[
                  bgColor.withOpacity(0.01),
                  bgColor.withOpacity(0.25),
                  bgColor.withOpacity(0.6),
                  bgColor.withOpacity(0.9),
                  bgColor
                   ],
                    begin:Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ) ,
            ),
          ),
          Positioned(
            left: 20.0,
            top: 240,
            child: Container(
              width: _width-20,
              child: Text(widget.data.title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26.0
              ),),
            ),
          ),
          Positioned(
            top: 290,
            left: 20,
            child: GetGenres(widget.data),
          ),
          Positioned(
              left: 20,
              right: 20,
              top: 400,
              child:Container(
                width: MediaQuery.of(context).size.width-40,
                height: 0.5,
                color: textColor,
              ),
          ),
          Positioned(
            top: 400,
            child: Container(
              margin: EdgeInsets.only(left: 20.0),
              width: MediaQuery.of(context).size.width,
              height: 120,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        width: (MediaQuery.of(context).size.width-40)/3,
                        height: 120,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(widget.data.popularity.toString(),
                                style:TextStyle(
                                  color: popularityColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24.0
                                ) ,
                              ),
                              Text("Popularity",
                                style:TextStyle(
                                    color:Colors.white,
                                ) ,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: (MediaQuery.of(context).size.width-40)/3,
                        height: 120,
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.star,color: iconColor,size: 26.0,),
                              RichText(
                                  text: TextSpan(
                                    text: widget.data.vote_avg,
                                    style:TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 20.0),
                                    children: <TextSpan>[
                                      TextSpan(
                                        text: "/10",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  )
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        width: (MediaQuery.of(context).size.width-40)/3,
                        height: 120,
                        child:Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(widget.data.vote_count.toString(),
                                style:TextStyle(
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.0
                                ) ,
                              ),
                              Text("Vote Count",
                                style:TextStyle(
                                  color:Colors.white,
                                ) ,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            top: 520,
            child:Container(
              width: MediaQuery.of(context).size.width-40,
              height: 0.5,
              color: textColor,
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            top: 530,
            child:Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height-530,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text("Description",
                      style:TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8.0,),
                    Text(widget.data.overview,
                      style:TextStyle(
                        color: Colors.white,
                        fontSize: 18.0,
                      ),
                    ),
                    SizedBox(height: 16.0,),
                    Text("Trailers",
                      style:TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.0,),
                    Preloadcontent(widget.data.id,widget.data),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class GetGenres extends StatefulWidget {
  Result data;
  GetGenres(this.data);
  @override
  _GetGenresState createState() => _GetGenresState();
}

class _GetGenresState extends State<GetGenres> {
  Repositery repo=Repositery();

  loadGenre(BuildContext contexts){
    final genresBloc = BlocProvider.of<GenresBloc>(contexts);
    genresBloc.add(FetchGenres(repo));
  }

  List<String> extract(String str){
    List<String> data=str.split(",");
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) =>GenresBloc(),
        child: BlocListener<GenresBloc,GenresState>(
          listener:(BuildContext context, GenresState state) {
            if (state is  GenresLoaded) {
              print("Loaded: genres");
            }
          },
          child:BlocBuilder<GenresBloc,GenresState>(
            builder: (BuildContext context, GenresState state) {
              // Changing the UI based on the current state
              if (state is InitialGenresState) {
                loadGenre(context);
                return CircularProgressIndicator();
              }else if (state is GenresLoaded) {
                List<String> items=extract(state.genreModel.getGenre(widget.data.genre_ids));
                return Container(
                  width:MediaQuery.of(context).size.width-20,
                  child: Wrap(
                    direction: Axis.horizontal,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    spacing: 8.0,
                    runSpacing: 8.0,
                    children: items.map((item) => RowItem(item)).toList().cast<Widget>(),
                  ),
                );
              }
            },
          ) ,
        ),
      ),
    );
  }

  Widget RowItem(String data){
    return  Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(20.0)
      ),
      child: Padding(
        padding: const EdgeInsets.only(left:10.0 ,right:10.0 ,top:5.0 ,bottom: 5.0),
        child: Text(data,
          style: TextStyle(
              color: Colors.white
          ),),
      ),
    );
  }
}

class Preloadcontent extends StatefulWidget {
  int id;
  Result model;

  @override
  _PreloadcontentState createState() => _PreloadcontentState();

  Preloadcontent(this.id,this.model);
}

class _PreloadcontentState extends State<Preloadcontent> {

  Repositery repo=Repositery();

  loadTrailer(BuildContext contexts){
    final trailersBloc = BlocProvider.of<TrailersBloc>(contexts);
    print(widget.id);
    trailersBloc.add(FetchTrailers(repo,widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocProvider(
        create: (context) =>TrailersBloc(),
        child: BlocListener<TrailersBloc,TrailersState>(
          listener:(BuildContext context, TrailersState state) {
            if (state is TrailerLoaded) {
              print("Loaded: ${state.trailerModel}");
            }
          },
          child:BlocBuilder<TrailersBloc,TrailersState>(
            builder: (BuildContext context, TrailersState state) {
              // Changing the UI based on the current state
              if (state is InitialTrailersState) {
                loadTrailer(context);
                return CircularProgressIndicator();
              }else if (state is TrailerLoaded) {
                return TrailerLoad(state.trailerModel,widget.model);
              }
            },
          ) ,
        ),
      ),
    );
  }
}

class TrailerLoad extends StatefulWidget {
  TrailerModel trailerModel;
  Result itemModel;
  @override
  _TrailerLoadState createState() => _TrailerLoadState();

  TrailerLoad(this.trailerModel,this.itemModel);
}

class _TrailerLoadState extends State<TrailerLoad> {
  @override
  Widget build(BuildContext context) {
    double itemWidth=(MediaQuery.of(context).size.width-16) /2;
    return Container(
      height:(widget.trailerModel.results.length).toDouble()*150,
      width: MediaQuery.of(context).size.width,
      child: GridView.count(
        padding: EdgeInsets.all(0),
        crossAxisSpacing: 16,
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        childAspectRatio: itemWidth/155,
        physics: NeverScrollableScrollPhysics(),
        children:new List<Widget>.generate(widget.trailerModel.results.length, (index){
            return GridTile(
                child: InkWell(
                  onTap: ()=> _launchURL("https://www.youtube.com/watch?v="+
                  widget.trailerModel.results[index].key),
                  child:Container(
                    width: MediaQuery.of(context).size.width,
                    child: InkWell(
                      onTap: ()=>_launchURL("https://www.youtube.com/watch?v="+
                          widget.trailerModel.results[index].key),
                      child: Wrap(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(bottom: 5),
                            child: Stack(
                              children: <Widget>[
                                Image.network("http://image.tmdb.org/t/p/w185/"+widget.itemModel.backdrop_path),
                                Container(
                                  width: itemWidth,
                                  height: 100,
                                  color: Colors.black38,
                                ),
                                Positioned(
                                  top: 36,
                                    left: (itemWidth-36-16)/2,
                                    child: Icon(Icons.play_circle_filled,
                                      size: 36,
                                      color: Colors.white,
                                    )
                                )
                              ],
                            ),
                          ),
                          Text(widget.itemModel.title,style: TextStyle(color: Colors.white),)
                        ],
                      ),
                    ),
                  ) ,
                )
            );
          }),
      ),
    );
  }
}



