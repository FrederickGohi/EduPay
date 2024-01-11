class Devoirs {
  var id;
  String semestre;
  String matiere;
  String date;
  String heure_debut;
  String heure_fin;
  String classe;

  Devoirs(
      {required this.id,
      required this.semestre,
      required this.matiere,
      required this.date,
      required this.heure_debut,
      required this.heure_fin,
      required this.classe,
      });

  factory Devoirs.fromJson(Map<String, dynamic> json) => Devoirs(
        id: json['id'],
        semestre: json['semestre'],
        matiere: json['matiere'],
        date: json['date'],
        heure_debut: json['heure_debut'],
        heure_fin: json['heure_fin'],
        classe: json['classe'],

      );

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'semestre': this.semestre,
        'matiere': this.matiere,
        'date': this.date,
        'heure_debut': this.heure_debut,
        'heure_fin': this.heure_fin,
        'classe': this.classe,
      };
}