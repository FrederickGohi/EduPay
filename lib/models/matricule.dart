class Matricule {
  int id;
  String matricule;
  String nom;
  String prenom;
  String date_naissance;
  String lieu_naissance;
  String classe;
  String telephone;


  // int idEcole;
  // int idClasse;

  Matricule(
      {required this.id,
      required this.matricule,
      required this.nom,
      required this.prenom,
      required this.date_naissance,
      required this.lieu_naissance,
      // required this.idEcole,
      required this.classe,
      required this.telephone,

      // required this.idClasse
      });

  factory Matricule.fromJson(Map<String, dynamic> json) => Matricule(
        id: int.parse(json['id']),
        matricule: json['matricule'],
        nom: json['nom'],
        prenom: json['prenom'],
        date_naissance: json['date_naissance'],
        lieu_naissance: json['lieu_naissance'],
        // idEcole: int.parse(json['id_ecole']),
        // idClasse: int.parse(json['id_classe']),
        classe: json['classe'],
        telephone: json['telephone'],

      );

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'matricule': this.matricule,
        'nom': this.nom,
        'prenom': this.prenom,

        'date_naissance': this.date_naissance,
        'lieu_naissance': this.lieu_naissance,
        // 'idEcole': this.idEcole,
        // 'idClasse': this.idClasse,
        'classe': this.classe,
        'telephone': this.telephone,

      };
}
