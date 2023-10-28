class Profs {
  var id;
  String nom;
  String prenom;
  String matiere;
  String email;
  String telephone;
  String classe;

  Profs(
      {required this.id,
      required this.nom,
      required this.prenom,
      required this.matiere,
      required this.email,
      required this.telephone,
      required this.classe,
      });

  factory Profs.fromJson(Map<String, dynamic> json) => Profs(
        id: json['id'],
        nom: json['nom'],
        prenom: json['prenom'],
        matiere: json['matiere'],
        email: json['email'],
        telephone: json['telephone'],
        classe: json['classe'],

      );

  Map<String, dynamic> toJson() => {
        'id': this.id,
        'nom': this.nom,
        'prenom': this.prenom,
        'matiere': this.matiere,
        'email': this.email,
        'telephone': this.telephone,
        'classe': this.classe,
      };
}