class ExamensClasse {
  int id;
  int id_eleve;
  int id_classe;
  int id_matiere;
  int type;
  String libelle;
  String date;

  ExamensClasse(
      {required this.id,
      required this.id_eleve,
      required this.id_classe,
      required this.id_matiere,
      required this.type,
      required this.libelle,
      required this.date,
      });

  factory ExamensClasse.fromJson(Map<String, dynamic> json) => ExamensClasse(
        id: int.parse(json['id']),
        id_eleve: int.parse(json['id_eleve']),
        id_classe: int.parse(json['id_classe']),
        id_matiere: int.parse(json['id_matiere']),
        type: int.parse(json['type']),
        libelle: json['libelle'],
        date: json['date'],

      );

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'id_eleve': this.id_eleve,
        'id_classe': this.id_classe,
        'id_matiere': this.id_matiere,
        'type': this.type,
        'libelle': this.libelle,
        'date': this.date,
      };
}