class Cantine {
  int id;
  String libelle;
  String montant;
  int idClasse;


  Cantine({
    required this.id,
    required this.libelle,
    required this.montant,
    required this.idClasse

  });

  factory Cantine.fromJson(Map<String, dynamic> json) => Cantine(
        id: int.parse(json['id']),
        libelle: json['libelle'],
        montant: json['montant'],
        idClasse: int.parse(json['id_classe']),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'libelle': libelle,
        'montant': montant,
        'idClasse': idClasse,
      };
}
