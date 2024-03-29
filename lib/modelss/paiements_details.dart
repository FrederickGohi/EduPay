class PaiementDetails {
  int id;
  String anneeScolaire;
  int idUser;
  String nomParent;
  String email;
  String schoolid;
  String nomEleve;
  String prenomEleve;
  String dateNaissance;
  String lieuNaissance;
  String classe;
  String matricule;
  String ecole;
  int montantInitial;
  int fraisOperateur;
  int fraisEdupay;
  String montant;
  String telephone;
  String reference;
  String dateTransaction;
  int statut;
  String type;

  PaiementDetails(
      {required this.id,
      required this.anneeScolaire,
      required this.idUser,
      required this.nomParent,
      required this.email,
      required this.schoolid,
      required this.nomEleve,
      required this.prenomEleve,
      required this.dateNaissance,
      required this.lieuNaissance,
      required this.classe,
      required this.matricule,
      required this.ecole,
      required this.montantInitial,
      required this.fraisOperateur,
      required this.fraisEdupay,
      required this.montant,
      required this.telephone,
      required this.reference,
      required this.dateTransaction,
      required this.statut,
      required this.type});

  factory PaiementDetails.fromJson(Map<String, dynamic> json) =>
      PaiementDetails(
        id: int.parse(json['id']),
        anneeScolaire: json['annee_scolaire'],
        idUser: int.parse(json['id_user']),
        nomParent: json['nom_parent'],
        email: json['email'],
        schoolid: json['schoolid'],
        nomEleve: json['nom_eleve'],
        prenomEleve: json['prenom_eleve'],
        dateNaissance: json['date_naissance'],
        lieuNaissance: json['lieu_naissance'],
        classe: json['classe'],
        matricule: json['matricule'],
        ecole: json['ecole'],
        montantInitial: int.parse(json['montant_initial']),
        fraisOperateur: int.parse(json['frais_operateur']),
        fraisEdupay: int.parse(json['frais_edupay']),
        montant: json['montant'],
        telephone: json['telephone'],
        reference: json['reference'],
        dateTransaction: json['date_transaction'],
        statut: int.parse(json['statut']),
        type: json['type'],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'anneeScolaire': anneeScolaire,
        'id_user': idUser,
        'nomParent': nomParent,
        'email': email,
        'schoolid': schoolid,
        'nomEleve': nomEleve,
        'penomEleve': prenomEleve,
        'dateNaissance': dateNaissance,
        'lieuNaissance': lieuNaissance,
        'classe': classe,
        'matricule': matricule,
        'ecole': ecole,
        'montantInitial': montantInitial,
        'fraisOperateur': fraisOperateur,
        'fraisEdupay': fraisEdupay,
        'montant': montant,
        'telephone': telephone,
        'reference': reference,
        'dateTransaction': dateTransaction,
        'statut': statut,
        'type': type
      };
}
