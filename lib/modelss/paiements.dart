class Paiement {
  String prenom_eleve;
  String classe;


  Paiement({
    required this.prenom_eleve,
    required this.classe
  });

  factory Paiement.fromJson(Map<String, dynamic> json) => Paiement(
        prenom_eleve: json['prenom_eleve'],
        classe: json['classe'],

      );

  Map<String, dynamic> toJson() => {
        'prenom_eleve': this.prenom_eleve,
        'classe': this.classe,

      };
}
