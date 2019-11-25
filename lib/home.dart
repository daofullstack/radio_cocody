import'package:flutter/material.dart';
/*
Column(
                          children: <Widget>[
                            blockProgramme("16:00:00 -18:00:00", "ET C'EST PARTI",
                              "retrouver tous les hits et tubes du moment",
                              "C'est une émission detente,enjouée ,vive a caractere musicale visant a égayer les auditeurs pendant 02 heures d'antennes presenté par herve mondesir"
                              ),
                              blockProgramme("12:00:00- 13:30:00", "RENDEZ VOUS DE LA FM",
                              "Un magazine reservé au partenaire de la radio",
                              "C'est une émission au cours de laquelle l'on reçoit les differents partenaires de la radio cocody fm en mettant en relief leur activités , prestation et services présenté par monsieur herve mondesir et massandje camara"
                              ),
                              blockProgramme("08:00:00 -11:00:00", "SOLEIL MAGAZINE",
                              "retrouver tous les hits et tubes du moment",
                              "Magazine generale d'informations et de divertissement de la radio présenté par PARKER SAKO"
                              ),
                               blockProgramme("13:00:00- 14:00:00", "total digital",
                              "emission tic de la radio",
                              "total digital est une émission des tic au cours de laquelle l'on parle des differents metiers de l'informatique,des tic dans le monde et une rubrique réservée à notre partenaire digital NAN.\r\n\r\nPresenté par kevine amon et armand bale"
                              ),
                              blockProgramme("21:15:00 -23:00:00", "YeTeParleDeLaLife",
                              "La vie est belle bro",
                              "On te parle pour la life bro"
                              ),
                     ],
                  )
*/



/*
    return FutureBuilder(
      future: CategoriesService.getAll(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          List<Categorie> categorie = snapshot.data;
          Navigation(String name) {
            Navigator.pushNamed(context, prefix1.Produits.routeName,arguments: prefix1.Produits(categorie: categorie.firstWhere((i)=>i.nom==name),));
          }
          return Scaffold(
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: (){
                  Navigator.pop(context);
                },
                color: Colors.grey,),
              title: Text('CATEGORIES ', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),),
              centerTitle: false,
              elevation: 0,
              backgroundColor: Colors.white,
              actions: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Icon(Icons.search, color: Colors.black54,),
                )
              ],
            ),
            body: Container(
              color: Colors.black38,
              width: double.infinity,
              height: double.infinity,
              child: ListView.builder(
                  itemCount: categorie.length,//produits.length
                  itemBuilder: (buildContext, index) => InkWell(

                    onTap: (){ print(categorie[index].produits[0]);
                      Navigation(categorie[index].nom);
                      //Navigator.push(context, MaterialPageRoute(builder: (context) => prefix1.Produits(categorie: categorie[index],)),
                      // );
                    },
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          image: DecorationImage(
                              image:AssetImage("assets/images/ch.jpeg"), //AssetImage("assets/images/{produits[index].image}"),//
                              fit: BoxFit.cover
                          )
                      ),
                      child: Text(categorie[index].nom, style: TextStyle(color: Colors.white, fontSize: 35.0, fontWeight: FontWeight.bold),),
                    ),
                  )
              ),
            ),
            bottomNavigationBar: BottomAppBar(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(icon: Icon(Icons.home,color: Colors.grey,), onPressed: (){}),
                  IconButton(icon: Icon(Icons.branding_watermark,color: Colors.blue), onPressed: (){}),
                  IconButton(icon: Icon(Icons.shopping_cart,color: Colors.grey), onPressed: (){}),
                  IconButton(icon: Icon(Icons.account_box,color: Colors.grey), onPressed: (){})
                ],
              ),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );




 */

class HomeRadio extends StatefulWidget {
  @override
  _HomeRadioState createState() => _HomeRadioState();
}

class _HomeRadioState extends State<HomeRadio> with SingleTickerProviderStateMixin{
  TabController _tabController;

  @override
  Widget build(BuildContext context) {
    DefaultTabController(
      length: 3,
      child: Scaffold(
      appBar: new AppBar(
        title: new Text("GrubX"),
        bottom: TabBar(
          unselectedLabelColor: Colors.white,
          labelColor: Colors.amber,
          tabs: [
          new Tab(icon: new Icon(Icons.call)),
          new Tab(
            icon: new Icon(Icons.chat),
          ),
          new Tab(
            icon: new Icon(Icons.notifications),
          )
        ],
        controller: _tabController,
        indicatorColor: Colors.white,
        indicatorSize: TabBarIndicatorSize.tab,),
        bottomOpacity: 1,
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: TabBarView(
            children: [
          new Text("This is call Tab View"),
          new Text("This is chat Tab View"),
          new Text("This is notification Tab View"),
        ],
        controller: _tabController,
        ),
      ),
      )

    );
  }
}
/**
 * 
 import 'dart:async';


import 'package:audioplayer/audioplayer.dart';


import 'package:flutter_radio/flutter_radio.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
    List<Music> listMusic=[
      Music(artiste: "akon", titre: "work",urlImage: "assets/images/a.jpg",urlMusic: "https://codabee.com/wp-content/uploads/2018/06/un.mp3"),
      Music(artiste: "asson", titre: "work",urlImage: "assets/images/b.jpg",urlMusic: "https://codabee.com/wp-content/uploads/2018/06/un.mp3"),
      Music(artiste: "arron", titre: "work",urlImage: "assets/images/c.jpg",urlMusic: "https://codabee.com/wp-content/uploads/2018/06/deux.mp3"),
      Music(artiste: "adjon", titre: "work",urlImage: "assets/images/d.jpg",urlMusic: "https://codabee.com/wp-content/uploads/2018/06/deux.mp3"),
  ];
  StreamSubscription positionSub;
  StreamSubscription stateSubscription;
  Music maMusicActuelle;
  AudioPlayer audioPlayer;
  Duration position=Duration(seconds: 0);
  Duration duree=Duration(seconds: 0);
  playerState statut=playerState.stopped;
  int index =0;
  //String url = "https://ia802708.us.archive.org/3/items/count_monte_cristo_0711_librivox/count_of_monte_cristo_001_dumas.mp3";
   String url = "http://radio.nan.ci:8000/stream";
  @override
  void initState() {
    maMusicActuelle= listMusic[index];
    super.initState();
    audioStart();
    configureAudioPlayer();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Container(
        height: double.infinity,
                  width: double.infinity,
       color: Colors.cyan,
       child:Column(children: <Widget>[   
              Container(
               
                  child: Column(
                    children: <Widget>[
                      Image.asset('assets/images/a.jpg',fit: BoxFit.cover,),
                      Text("my love"),
                      bouton( 
                        (statut==playerState.playing)? Icons.pause_circle_filled: Icons.play_arrow, 40,
                         (statut==playerState.playing)? ActionMusic.pause :ActionMusic.play)
                    ],
                  ),
                ),
                FlatButton(
                child: Icon(Icons.play_circle_filled),
                onPressed: () => FlutterRadio.play(url: url),
              ),
              FlatButton(
                child: Icon(Icons.pause_circle_filled),
                onPressed: () => FlutterRadio.pause(url: null),
              ),
       ],)
     ),
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
         
          pause();
          break;
        case ActionMusic.play:
         print('play');
          play();
          break;
        case ActionMusic.rewind:
          rewind();
          break;
        case ActionMusic.forward:
          forward();
          break;
    }
    },
  );
}

Text texteAvecStyle(String data, double scale, ){
  return Text(data, textScaleFactor: scale,
  textAlign: TextAlign.center,
  style: TextStyle(
    color: Colors.white,
     fontStyle: FontStyle.italic, fontSize: 20.0),);
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
  Future<void> audioStart() async {
    await FlutterRadio.audioStart();
    print('Audio Start OK');
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
void rewind(){
  if (position > Duration(seconds: 3)) {
    audioPlayer.seek(0.0);
  } else {
      if (index == listMusic.length-1){
    index=0;
  }else{
    index--;
    maMusicActuelle=listMusic[index];
    audioPlayer.stop();
    play();
  }
  }
}

void forward (){
  if (index == listMusic.length-1){
    index=0;
  }else{
    index ++;
      }
    maMusicActuelle=listMusic[index];
    audioPlayer.stop();
    play();
}

  String fromDuration(Duration duree){
     return duree.toString().split('.').first;
  }
}


enum ActionMusic{
  pause,
  play,
  rewind,
  forward
  
}

enum playerState{
  playing,
  stopped,
  paused
}

 */



/*


                                Container(
                  height: 50,
                  width: 50,
                  child: Column(
                    children: <Widget>[
                      Image.asset('assets/images/a.jpg'),
                      Text("my love")
                    ],
                  ),
                )

                */