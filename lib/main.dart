import 'dart:async';
import 'dart:convert';
import 'models.dart';

import 'package:audioplayer/audioplayer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;



void main() async {
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: ThemeData.dark(),
      title: "New Task",
      debugShowCheckedModeBanner: false,
      home: new HomePage(),
    );
 
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  TabController _tabController;
  StreamSubscription positionSub;
  StreamSubscription stateSubscription;
  AudioPlayer audioPlayer;
  Duration position=Duration(seconds: 0);
  Duration duree=Duration(seconds: 0);
  playerState statut=playerState.stopped;
  int index =0;

  List<String>  titreActu=[
    "Cérémonie d’ouverture CGECI-Academy 2019",
    "Diverses formes de consommations du café présentées",
    "La 5ième édition du SARA, du 22 novembre au 1er décembre à Abidjan",
    "Festival international de films des Lacs et Lagunes: La 8e édition",
    "Côte d’Ivoire: Guillaume Soro candidat à la présidentielle de 2020"
  ];

    var data;
  var isLoad=true;
  var url=('http://radiococodyfm.ci/playlist/api/planning/?format=json');
  String url2="data/radiococodyfm.ci.json";
  //List<Programme> detailProgramme=[];
  var programmes;
  Future loadProgrammeList() async{
    var content= await rootBundle.loadString(url2);
    List data=json.decode(content);
    List<Programme> _programmes=data.map((json)=>Programme.fromJson(json)).toList();
    setState(() {
     programmes=_programmes;
     //print('id=  ${programmes[1].id}');
    });
  }
 /*
  Future<List<Programme>> _detailProgramme()  async {
      var donnees= await http.get(url);
      var jsonDonnees=json.decode(donnees.body);
      for (var prog in jsonDonnees) {
        Programme  programme= Programme(prog['id'],prog['heur_debut'],prog['heur_fin'],);
        detailProgramme.add(programme);
      }
      return detailProgramme;
  }
   Future<dynamic> getData() async {
    var response = await http.get(
        Uri.encodeFull(url),
        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(() {
      isLoad=false;
      data = json.decode(response.body);

    });
/*     for (var item in data) {
      print('*****************0');
      print(item);
      print('*****************0');
    } */
    return "Success!";
  }
 */
  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    loadProgrammeList();
    super.initState();
    configureAudioPlayer();
     //this.getData();
    
  }

  @override
  Widget build(BuildContext context) {
    
      return new Scaffold(
          appBar: new AppBar(
            centerTitle: true,
            title: Row(
              children: <Widget>[
              Text("COCODY FM",style: TextStyle(color: Colors.white),),
              SizedBox(width: 2,),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Icon(Icons.lens, color: Colors.deepOrange,size: 12,),
                  SizedBox(height: 4,)
                ],
              ),
              //Text(".",style:TextStyle(color:Colors.deepOrangeAccent,fontSize: 30))
            ],),
            bottom: TabBar(
              unselectedLabelColor: Colors.white,
              labelColor: Colors.deepOrange,
              tabs: [
              new Tab(icon: new Icon(Icons.radio),child: Text("Channel"),),
              new Tab(
                icon: new Icon(Icons.pie_chart_outlined,),
                child:  Text("programme"),
              ),
              new Tab(
                icon: new Icon(Icons.navigation,),
                child:  Text("actualité"),
              ),
            ],
            controller: _tabController,
            indicatorColor: Colors.white,
            indicatorSize: TabBarIndicatorSize.tab,),
            bottomOpacity: 1,
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            child: Center(
              child: TabBarView(
                  children: [
                Container(
                  padding: EdgeInsets.all(10.0),
                  color: Colors.black12,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Stack(children: <Widget>[
                        Container(
                          child: (statut==playerState.playing)? SpinKitWave(
                            color: Colors.deepOrangeAccent,
                            size: 80,
                          ):Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(color: Colors.orangeAccent,height: 10,width: 5,padding: EdgeInsets.only(right: 20),),
                              Container(color: Colors.orangeAccent,height: 10,width: 5,padding: EdgeInsets.only(right: 20),),
                              Container(color: Colors.orangeAccent,height: 10,width: 5,padding: EdgeInsets.only(right: 20),),
                            ],
                          ),
                          ),
                          Positioned(
                            left: 90,
                            child: Container(
                              child: Text('98.5 ',
                              style: TextStyle(
                                fontSize: 60,
                                fontWeight: FontWeight.bold),),),),
                      ],),
                      Container(
                        //height: MediaQuery.of(context).size.height/16,
                        width: double.infinity,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            IconButton(
                              onPressed: (){

                              },
                              color: Colors.deepOrange,
                              icon: Icon(Icons.favorite,size: 40,),
                            ),
                            Text('Cocody fm', style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold)),
                             Text('cocody fm 98.5 - Top 10', style: TextStyle(color: Colors.white.withOpacity(.5),fontSize: 13,)),
                             ],
                        ),
                      ),
                      Stack(
                        children: <Widget>[
                          Align(alignment: Alignment(-0.056, -1),
                                child: Column(
                                children: <Widget>[
                                  Container(
                                  height: 100,
                                  width: 3,color: Colors.deepOrange,
                                  margin: EdgeInsets.all(2.0),
                                  padding: EdgeInsets.only(bottom: 16),),
                                  Icon(
                                    Icons.navigation,
                                    color: Colors.deepOrange,),
                                ],
                                    ),
                          ),
                          Container(
                          
                          child: Row(
                            //crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                             
                                 barVerticale(),
                                  barVerticale(),
                                  barVerticale2(92.0),
                              barVerticale(),
                                barVerticale(),
                                 barVerticale(),
                                  barVerticale(),
                                  barVerticale2(94.0),
                              barVerticale(),
                                barVerticale(),
                                 barVerticale(),
                                  barVerticale(),
                                  barVerticale2(96.0),
                              barVerticale(),
                                barVerticale(),
                                 barVerticale(),
                                  barVerticale(),
                                  barVerticale2(98.0),
                              barVerticale(),
                                barVerticale(),
                                 barVerticale(),
                                  barVerticale(),
                                  barVerticale2(100),
                              barVerticale(),
                                barVerticale(),
                                 barVerticale(),
                                  barVerticale(),
                                  barVerticale2(102),
                              barVerticale(),
                                barVerticale(),
                                 barVerticale(),
                                  barVerticale(),
                                  barVerticale2(104.0),
                          barVerticale(),
                                barVerticale(),
                              
                            ],
                          ),
                        ),

                        ],
                      ),
                         bouton( 
                            (statut==playerState.playing)? Icons.pause_circle_filled: Icons.play_arrow, 40,
                             (statut==playerState.playing)? ActionMusic.pause :ActionMusic.play)
                    ],
                  ),
                ),
                Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Colors.white,
                  child:ListView.builder(
                     itemCount: programmes.length,
                     itemBuilder: (ctx,index){
                       Programme programme=programmes[index];
                       return blockProgramme(
                         '${programme.heurDebut} ' + '-- ${programme.heurFin}',
                          programme.emissions.titre,
                          programme.emissions.miniDescription,
                          programme.emissions.description
                          );
                     },
                    )
                  ),
                Container(
                  height: double.infinity,
                  width:double.infinity,
                  padding: EdgeInsets.all(5.0),
                  child:Center(child:ListView.builder(
                    padding: EdgeInsets.all(5.0),
                    itemCount: 5,
                    itemBuilder: (context, index){
                      return Card(
                        elevation: 4,
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 180.0,
                          child: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                child: Image.asset(
                                  'assets/images/${index +1}.jpg',
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                bottom: 16.0,
                                left: 16.0,
                                right: 16.0,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    '${index +1}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline
                                        .copyWith(color: Colors.white70),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        ButtonTheme.bar(
                          child: ButtonBar(
                           alignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Column(children: <Widget>[
                                 Container(
                                  child:Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                    Container(width: MediaQuery.of(context).size.width*0.8,
                                      child:Text(
                                        titreActu[index],softWrap: true,
                                        style: TextStyle(color: Colors.black)
                                        ),
                                        ),
                                      ],
                                      )
                                      ),
                                      Container(
                                        width: MediaQuery.of(context).size.width*0.8,
                                      //color: Colors.black38,
                                        child:Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                        Text('En savoir plus',style: TextStyle(color: Colors.deepOrange)),
                                        Icon(Icons.play_arrow, color: Colors.black,)
                                      ],
                                      )
                                      ),
                              ],)
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                
                    
                    },
                    ),
                    )
                )
              ],
              controller: _tabController,
              ),
            ),
          ),
        );
      
      
    
    }
    void configureAudioPlayer(){
  audioPlayer=AudioPlayer();
  positionSub=audioPlayer.onAudioPositionChanged.listen(
    (pos)=>setState(()=> position=pos)
  );
  stateSubscription=audioPlayer.onAudioPositionChanged.listen(
    (state){
      if(state== AudioPlayerState.PLAYING){
        setState(() {
         duree=audioPlayer.duration; 
        });
      } else if(state== AudioPlayerState.STOPPED){
        setState(() {
        statut=playerState.stopped;
        });
      }
    },
    onError: (message){
      print('$message');
      setState(() {

      statut=playerState.stopped;
      duree =Duration(seconds: 0);
      position=Duration(seconds: 0);
      });
    }
  );
}
IconButton bouton(
  IconData icone,double taille,ActionMusic action){
  return IconButton(
    iconSize: taille,
    color: Colors.white,
    icon: Icon(icone),
    onPressed: (){
      switch(action){
        case ActionMusic.pause:
                  print('pause');
          pause();
          break;
        case ActionMusic.play:
         print('play');
          play();
          break;
    }
    },
  );
  
}

Future play() async {
  await audioPlayer.play("http://radio.nan.ci:8000/stream");
  //await audioPlayer.play(maMusicActuelle.urlMusic);
  setState(() {
   statut=playerState.playing; 
  });
}
Future pause() async {
  await audioPlayer.pause();
  setState(() {

   statut=playerState.paused; 
  });
}

  Widget barVerticale(){
  return Container(height: 40,width: 1,color: Colors.white,margin: EdgeInsets.all(1.0),);
  }
    Widget barVerticale2(double numFrequence){
  return Column(
    children: <Widget>[
      Container(height: 65,width: 1.5,color: Colors.deepOrangeAccent,margin: EdgeInsets.all(1.0),padding: EdgeInsets.only(bottom: 16),),
      Text("$numFrequence", style: TextStyle(color: Colors.white,fontSize: 12,)),
    ],
  );
  }
  Widget blockProgramme(String programme,String titre,String text1, String text2){
    return  Container(
              padding: EdgeInsets.all(12.0),
              color: Colors.white,
              child: Column(children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(Icons.crop_square,color: Colors.black,size: 20,),
                          Container(
                            width:MediaQuery.of(context).size.width*0.8,
                            padding: EdgeInsets.all(12.0) ,
                            //height: MediaQuery.of(context).size.height/16,
                            color: Colors.black,
                            child: Text(programme,   
                            style:TextStyle(color: Colors.white,fontSize: 20,),
                          ))
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          top: 10,left: MediaQuery.of(context).size.width/4.43,
                          right: 10,bottom: 10
                          ),
                      color: Colors.white10,
                      //height: MediaQuery.of(context).size.height/5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(titre,style: TextStyle(color: Colors.black,fontSize: 25,),),
                           Divider(),
                           Text(text1,
                           style: TextStyle(color: Colors.black,fontSize: 20,),),
                           Divider(),
                            Text(text2,
                            style: TextStyle(color: Colors.black,fontSize: 20,),
                            ),
                        ],
                      ),
                      
                      )

                    ],),);
  }
}

enum ActionMusic{
  pause,
  play,
  
}

enum playerState{
  playing,
  stopped,
  paused
}

/* import 'package:flutter/material.dart';

import 'home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeRadio(),
    );
  }
}

*/