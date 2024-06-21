import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:prime_stream/apikey/apikey.dart';
import 'package:prime_stream/screens/PeliculasDetail.dart';

class Peliculas extends StatefulWidget {
  const Peliculas({super.key});

  @override
  State<Peliculas> createState() => _PeliculasState();
}

class _PeliculasState extends State<Peliculas> {
  List<Map<String, dynamic>> popularmovies = [];
  List<Map<String, dynamic>> nowplayingmovies = [];
  List<Map<String, dynamic>> topratedmovies = [];

  Future<void> moviesfunction() async {
    var popularmoviesurl =
        'https://api.themoviedb.org/3/movie/popular?api_key=$API_KEY&language=es-MX';
    var nowplayingmoviesurl =
        'https://api.themoviedb.org/3/movie/now_playing?api_key=$API_KEY&language=es-MX';
    var topratedmoviesurl =
        'https://api.themoviedb.org/3/movie/top_rated?api_key=$API_KEY&language=es-MX';

    var popularmoviesresponse = await http.get(Uri.parse(popularmoviesurl));
    if (popularmoviesresponse.statusCode == 200) {
      var tempdata = jsonDecode(popularmoviesresponse.body);
      var popularmoviesjson = tempdata['results'];
      for (var i = 0; i < popularmoviesjson.length; i++) {
        popularmovies.add({
          "name": popularmoviesjson[i]["title"],
          "poster_path": popularmoviesjson[i]["poster_path"],
          "vote_average": popularmoviesjson[i]["vote_average"],
          "Date": popularmoviesjson[i]["release_date"],
          "id": popularmoviesjson[i]["id"],
        });
      }
    } else {
      print(popularmoviesresponse.statusCode);
    }

    ///////////////////////////////////////////////////////////////////////////////
    var nowplayingmoviesresponse =
        await http.get(Uri.parse(nowplayingmoviesurl));
    if (nowplayingmoviesresponse.statusCode == 200) {
      var tempdata = jsonDecode(nowplayingmoviesresponse.body);
      var nowplayingmoviesjson = tempdata['results'];
      for (var i = 0; i < nowplayingmoviesjson.length; i++) {
        nowplayingmovies.add({
          "name": nowplayingmoviesjson[i]["title"],
          "poster_path": nowplayingmoviesjson[i]["poster_path"],
          "vote_average": nowplayingmoviesjson[i]["vote_average"],
          "Date": nowplayingmoviesjson[i]["release_date"],
          "id": nowplayingmoviesjson[i]["id"],
        });
      }
    } else {
      print(nowplayingmoviesresponse.statusCode);
    }
    //////////////////////////////////////////////////////////////////////
    var topratedmoviesresponse = await http.get(Uri.parse(topratedmoviesurl));
    if (topratedmoviesresponse.statusCode == 200) {
      var tempdata = jsonDecode(topratedmoviesresponse.body);
      var topratedmoviesjson = tempdata['results'];
      for (var i = 0; i < topratedmoviesjson.length; i++) {
        topratedmovies.add({
          "name": topratedmoviesjson[i]["title"],
          "poster_path": topratedmoviesjson[i]["poster_path"],
          "vote_average": topratedmoviesjson[i]["vote_average"],
          "Date": topratedmoviesjson[i]["release_date"],
          "id": topratedmoviesjson[i]["id"],
        });
      }
    } else {
      print(topratedmoviesresponse.statusCode);
    }
    /////////////////////////////////////////////////////////////////////
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      
        future: moviesfunction(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
                child: CircularProgressIndicator( color: Colors.purpleAccent,));
          else {
            return Column(
              
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, top: 15, bottom: 20),
                    child: Text(
                      "Peliculas Populares:",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Container(
                    height: 300,
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: popularmovies.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PeliculasDetail(
                                        popularmovies[index]['id'])),
                              );
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 210,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                          colorFilter: ColorFilter.mode(
                                              Colors.black.withOpacity(0.3),
                                              BlendMode.darken),
                                          image: NetworkImage(
                                              'https://image.tmdb.org/t/p/w500${popularmovies[index]['poster_path']}'),
                                          fit: BoxFit.cover)),
                                  margin: EdgeInsets.only(
                                      left: 13, top: 10, bottom: 5),
                                  width: 150,
                                ),
                                Container(
                                    margin: EdgeInsets.only(
                                        left: 13, top: 5, bottom: 5),
                                    width: 150,
                                    child: Text(
                                      (popularmovies[index]['name'] as String)
                                          .toUpperCase(),
                                      style: TextStyle(fontSize: 12),
                                    )),
                                Container(
                                    margin:
                                        EdgeInsets.only(left: 13, bottom: 5),
                                    width: 150,
                                    child: Text(
                                      (popularmovies[index]['Date'] as String)
                                          .substring(0, 4),
                                      style: TextStyle(fontSize: 12),
                                    )),
                              ],
                            ),
                          );
                        }),
                  ),
                  /////////////////////////////////////////////////////////MEJOR CALIFICADAS//////////////////////////////////////////////////////
                  const Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, top: 15, bottom: 20),
                    child: Text(
                      "Mejor Calificadas:",
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                    ),
                  ),
                  Container(
                    height: 300,
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: topratedmovies.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PeliculasDetail(
                                        topratedmovies[index]['id'])),
                              );
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 210,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                          colorFilter: ColorFilter.mode(
                                              Colors.black.withOpacity(0.3),
                                              BlendMode.darken),
                                          image: NetworkImage(
                                              'https://image.tmdb.org/t/p/w500${topratedmovies[index]['poster_path']}'),
                                          fit: BoxFit.cover)),
                                  margin: EdgeInsets.only(
                                      left: 13, top: 10, bottom: 5),
                                  width: 150,
                                ),
                                Container(
                                    margin: EdgeInsets.only(
                                        left: 13, top: 5, bottom: 5),
                                    width: 150,
                                    child: Text(
                                      (topratedmovies[index]['name'] as String)
                                          .toUpperCase(),
                                      style: TextStyle(fontSize: 12),
                                    )),
                                Container(
                                    margin:
                                        EdgeInsets.only(left: 13, bottom: 5),
                                    width: 150,
                                    child: Text(
                                      (topratedmovies[index]['Date'] as String)
                                          .substring(0, 4),
                                      style: TextStyle(fontSize: 12),
                                    )),
                              ],
                            ),
                          );
                        }),
                  ),
                  /////////////////////////////////////////////////////////ULTIMAS PELICULAS//////////////////////////////////////////////////////
                  const Padding(
                    padding:
                        const EdgeInsets.only(left: 10.0, top: 15, bottom: 20),
                    child: Text(
                      "Ultimas Peliculas:",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                  ),
                  Container(
                    height: 300,
                    child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: nowplayingmovies.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PeliculasDetail(
                                        nowplayingmovies[index]['id'])),
                              );
                            },
                            child: Column(
                              children: [
                                Container(
                                  height: 210,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                          colorFilter: ColorFilter.mode(
                                              Colors.black.withOpacity(0.3),
                                              BlendMode.darken),
                                          image: NetworkImage(
                                              'https://image.tmdb.org/t/p/w500${nowplayingmovies[index]['poster_path']}'),
                                          fit: BoxFit.cover)),
                                  margin: EdgeInsets.only(
                                      left: 13, top: 10, bottom: 5),
                                  width: 150,
                                ),
                                Container(
                                    margin: EdgeInsets.only(
                                        left: 13, top: 5, bottom: 5),
                                    width: 150,
                                    child: Text(
                                      (nowplayingmovies[index]['name']
                                              as String)
                                          .toUpperCase(),
                                      style: TextStyle(fontSize: 12),
                                    )),
                                Container(
                                    margin:
                                        EdgeInsets.only(left: 13, bottom: 5),
                                    width: 150,
                                    child: Text(
                                      (nowplayingmovies[index]['Date']
                                              as String)
                                          .substring(0, 4),
                                      style: TextStyle(fontSize: 12),
                                    )),
                              ],
                            ),
                          );
                        }),
                  ),
                ]);
          }
        });
  }
}
