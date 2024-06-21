import 'dart:convert';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:prime_stream/apikey/apikey.dart';
import 'package:prime_stream/screens/catalogoScreen.dart';
import 'package:prime_stream/screens/trailerui.dart';
import 'package:prime_stream/screens/userreview.dart';
class PeliculasDetail extends StatefulWidget {
  var id;
  PeliculasDetail(this.id);

  @override
  State<PeliculasDetail> createState() => _PeliculasDetailState();
}

class _PeliculasDetailState extends State<PeliculasDetail> {
  List<Map<String, dynamic>> MovieDetails = [];

  List<Map<String, dynamic>> movietrailerslist = [];
  List MoviesGeneres = [];
   Future Moviedetails() async {
    var moviedetailurl = 'https://api.themoviedb.org/3/movie/' +
        widget.id.toString() +
        '?api_key=$API_KEY&language=es-MX';
 
    var movietrailersurl = 'https://api.themoviedb.org/3/movie/' +
        widget.id.toString() +
        '/videos?api_key=$API_KEY&language=es-MX';

    var moviedetailresponse = await http.get(Uri.parse(moviedetailurl));
    if (moviedetailresponse.statusCode == 200) {
      var moviedetailjson = jsonDecode(moviedetailresponse.body);
      for (var i = 0; i < 1; i++) {
        MovieDetails.add({
          "backdrop_path": moviedetailjson['backdrop_path'],
          "title": moviedetailjson['title'],
          "vote_average": moviedetailjson['vote_average'],
          "overview": moviedetailjson['overview'],
          "release_date": moviedetailjson['release_date'],
          "runtime": moviedetailjson['runtime'],
          "budget": moviedetailjson['budget'],
          "revenue": moviedetailjson['revenue'],
        });
      }
      for (var i = 0; i < moviedetailjson['genres'].length; i++) {
        MoviesGeneres.add(moviedetailjson['genres'][i]['name']);
      }
    } else {}

  
    

    /////////////////////////////movie trailers
    var movietrailersresponse = await http.get(Uri.parse(movietrailersurl));
    if (movietrailersresponse.statusCode == 200) {
      var movietrailersjson = jsonDecode(movietrailersresponse.body);
      for (var i = 0; i < movietrailersjson['results'].length; i++) {
        if (movietrailersjson['results'][i]['type'] == "Trailer") {
          movietrailerslist.add({
            "key": movietrailersjson['results'][i]['key'],
          });
        }
      }
      movietrailerslist.add({'key': 'aJ0cZTcTh90'});
    } else {}
    print(movietrailerslist);
  }

  // @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(14, 14, 14, 1),
      body: FutureBuilder(
        future: Moviedetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverAppBar(
                     automaticallyImplyLeading: false,
                        leading: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(FontAwesomeIcons.circleArrowLeft),
                            iconSize: 32,
                            color: Colors.white),
                            
                        backgroundColor: Color.fromRGBO(18, 18, 18, 0.5),
                        centerTitle: false,
                        pinned: true,
                        expandedHeight:
                            MediaQuery.of(context).size.height * 0.4,
                        flexibleSpace: FlexibleSpaceBar(
                          collapseMode: CollapseMode.parallax,
                          background: FittedBox(
                            fit: BoxFit.fill,
                            child: trailerwatch(
                              trailerytid: movietrailerslist[0]['key'],
                            ),
                          ),
                        )
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Column(
                         children: [
                          Row(children: [
                            Container(
                                padding: EdgeInsets.only(left: 10, top: 10),
                                height: 50,
                                width: MediaQuery.of(context).size.width,
                                child: ListView.builder(
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount: MoviesGeneres.length,
                                    itemBuilder: (context, index) {
                                      //generes box
                                      return Container(
                                          margin: EdgeInsets.only(right: 10),
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color:
                                                  Color.fromRGBO(106, 5, 131, 1),
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child:
                                              Text(MoviesGeneres[index], style: TextStyle(color: Colors.white),));
                                    })),
                          ]),
                          Row(
                            children: [
                              Container(
                                  padding: EdgeInsets.all(10),
                                  margin: EdgeInsets.only(left: 10, top: 10),
                                  height: 40,
                                  decoration: BoxDecoration(
                                      color: Color.fromRGBO(37, 18, 212, 1),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                      MovieDetails[0]['runtime'].toString() +
                                          ' min', style: TextStyle(color: Colors.white)))
                            ],
                          )
                         ]
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: 20, top: 10),
                          child: Text('Historia :',style: TextStyle(color: Colors.white))),
                      Padding(
                          padding: EdgeInsets.only(left: 20, top: 10),
                          child: Text(
                              MovieDetails[0]['overview'].toString(),style: TextStyle(color: Colors.white))),

                      Padding(
                          padding: EdgeInsets.only(left: 20, top: 20),
                          child: Text('Fecha de Estreno : ' +
                              MovieDetails[0]['release_date'].toString(),style: TextStyle(color: Colors.white))),
                      Padding(
                          padding: EdgeInsets.only(left: 20, top: 20),
                          child: Text('Presupuesto : ' +
                              MovieDetails[0]['budget'].toString(), style: TextStyle(color: Colors.white))),
                              Padding(
                          padding: EdgeInsets.only(left: 20, top: 20),
                          child: Text('Recaudado : ' +
                              MovieDetails[0]['revenue'].toString(),style: TextStyle(color: Colors.white))),

                    ])
                  )
                ],
              );
            }
          else{
            return Center(
                  child: CircularProgressIndicator(
                color: Colors.purpleAccent,
              ));
          }
   } )
    );
  }
}