import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:convert';
import 'package:prime_stream/apikey/apikey.dart';
import 'package:prime_stream/screens/Peliculas.dart';
import 'package:prime_stream/screens/PeliculasDetail.dart';
void main() {
  runApp(const Catalogo());
}

class Catalogo extends StatelessWidget {
  const Catalogo({super.key});

  @override
  Widget build(BuildContext context) {
     return const MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  
//funcion creada
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: TrendSlider(context),
    );
  }
}


List<Map<String, dynamic>> trendinglist = [];
  Future<void> trendinglisthome() async {
     var trendingweekurl =
          'https://api.themoviedb.org/3/trending/movie/week?api_key=$API_KEY&language=es-MX';
      var trendingweekresponse = await http.get(Uri.parse(trendingweekurl));
      if (trendingweekresponse.statusCode == 200) {
        var tempdata = jsonDecode(trendingweekresponse.body);
        var trendingweekjson = tempdata['results'];
        for (var i = 0; i < trendingweekjson.length; i++) {
          trendinglist.add({
            'id': trendingweekjson[i]['id'],
            'poster_path': trendingweekjson[i]['poster_path'],
            'vote_average': trendingweekjson[i]['vote_average'],
            'media_type': trendingweekjson[i]['media_type'],
            'indexno': i,
          });
        }
        
        
        }
        
  }




Widget TrendSlider(context){
  return(
    CustomScrollView(
      
      slivers: [
        SliverAppBar(
          backgroundColor: Color.fromARGB(255, 133, 3, 156),
          centerTitle: true,
          toolbarHeight: 60,
          pinned: true,
          expandedHeight: MediaQuery.of(context).size.height*0.4,
          flexibleSpace: FlexibleSpaceBar(
           
            collapseMode: CollapseMode.parallax,
            background: FutureBuilder(
              future: trendinglisthome(),
              builder:(context, snapshot) {
                if(snapshot.connectionState==ConnectionState.done){
                  return CarouselSlider(
                    options: CarouselOptions(
                       viewportFraction: 1,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            height: MediaQuery.of(context).size.height),
                    items: trendinglist.map((i) {
                      return Builder(builder: (BuildContext context) {
                        return GestureDetector(
                           onTap: () {},
                           child: GestureDetector(
                              onTap: () {
                                  Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PeliculasDetail(
                                        i['id'])),
                              );

                              },
                              child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            // color: Colors.amber,
                                            image: DecorationImage(
                                                colorFilter: ColorFilter.mode(
                                                    Colors.black
                                                        .withOpacity(0.3),
                                                    BlendMode.darken),
                                                image: NetworkImage(
                                                    'https://image.tmdb.org/t/p/w500${i['poster_path']}'),
                                                fit: BoxFit.fill)),
                                               
                                                )
                           )
                        );
                      });
                    }).toList()
                    );
                }else{
                  return Center(
                    child: CircularProgressIndicator(
                      color: Colors.purpleAccent,
                    )
                  );
                }
                
              },
              ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('PrimeStream',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.8), fontSize: 22, fontWeight:FontWeight.bold)),
                  SizedBox(width: 10),
            ],),
          
        ),
        SliverList(delegate: SliverChildListDelegate([
        
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 231, 231, 235),
          
        ),
            height: 1090,
            child: Peliculas(),
          )
          
        ])),
       
      ],
    )
  );


}







