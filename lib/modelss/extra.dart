class Extra {
  int id;
  String libelle;
  String montant;
  int idClasse;

  Extra(
      {required this.id,
      required this.libelle,
      required this.montant,
      required this.idClasse});

  factory Extra.fromJson(Map<String, dynamic> json) => Extra(
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
