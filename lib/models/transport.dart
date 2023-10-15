class Transport {
  int id;
  String libelle;
  String montant;
  int idClasse;


  Transport({
    required this.id,
    required this.libelle,
    required this.montant,
    required this.idClasse

  });

  factory Transport.fromJson(Map<String, dynamic> json) => Transport(
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
