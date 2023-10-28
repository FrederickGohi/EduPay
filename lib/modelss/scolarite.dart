class Scolarite {
  int id;
  String libelle;
  String montant;
  int idClasse;


  Scolarite({
    required this.id,
    required this.libelle,
    required this.montant,
    required this.idClasse

  });

  factory Scolarite.fromJson(Map<String, dynamic> json) => Scolarite(
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