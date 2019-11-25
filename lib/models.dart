import 'dart:convert';

class Programme {
  int id;
  String heurDebut;
  String heurFin;
  Emission emissions;
  Programme({this.id,this.heurDebut,this.heurFin,this.emissions});
  factory Programme.fromJson(Map<String, dynamic> json){
    return Programme(
        id:json["id"],
        heurDebut:json['heur_debut'],
        heurFin:json['heur_fin'],
        emissions: Emission.fromJson(json['emission'])
       
     );
  }
 
  
 // emissions= Emission.fromJson(json['emission']).toList();
  //List<Programme> _programmes=data.map((json)=>Programme.fromJson(json)).toList();
}
class Emission {
  final String titre;
  final String miniDescription;
  final String description;

  Emission(this.titre, this.miniDescription, this.description);
  Emission.fromJson(Map<String,dynamic> jsonEmission):
  titre=jsonEmission["titre"],
  miniDescription=jsonEmission['mini_description'],
  description=jsonEmission['description'];
}