class PaiementDetails {
  int id;
  String anneeScolaire;
  int idUser;
  String nomParent;
  String email;
  String eleve;
  String nomEleve;
  String prenomEleve;
  String dateNaissance;
  String lieuNaissance;
  String classe;
  String matricule;
  String modePaiement;
  int montantInitial;
  int fraisOperateur;
  int fraisEliah;
  String montant;
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
      required this.eleve,
      required this.nomEleve,
      required this.prenomEleve,
      required this.dateNaissance,
      required this.lieuNaissance,
      required this.classe,
      required this.matricule,
      required this.modePaiement,
      required this.montantInitial,
      required this.fraisOperateur,
      required this.fraisEliah,
      required this.montant,
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
        eleve: json['eleve'],
        nomEleve: json['nom_eleve'],
        prenomEleve: json['prenom_eleve'],
        dateNaissance: json['date_naissance'],
        lieuNaissance: json['lieu_naissance'],
        classe: json['classe'],
        matricule: json['matricule'],
        modePaiement: json['mode_paiement'],
        montantInitial: int.parse(json['montant_initial']),
        fraisOperateur: int.parse(json['frais_operateur']),
        fraisEliah: int.parse(json['frais_eliah']),
        montant: json['montant'],
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
        'eleve': eleve,
        'nomEleve': nomEleve,
        'penomEleve': prenomEleve,
        'dateNaissance': dateNaissance,
        'lieuNaissance': lieuNaissance,
        'classe': classe,
        'matricule': matricule,
        'modePaiement': modePaiement,
        'montantInitial': montantInitial,
        'fraisOperateur': fraisOperateur,
        'fraisEliah': fraisEliah,
        'montant': montant,
        'reference': reference,
        'dateTransaction': dateTransaction,
        'statut': statut,
        'type': type
      };
}
