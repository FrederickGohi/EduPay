import 'package:flutter/material.dart';

class TermsConditions extends StatelessWidget {
  const TermsConditions({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Couleurs.CouleurSecondaire,
        title: const Text("Termes et Conditions"),
        centerTitle: true,
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Conditions générales d'utilisation",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Merci d'utiliser notre application de paiement des frais d'écolage par LIA-PAY. En utilisant cette application, vous acceptez les Termes et Conditions énoncés ci-dessous :",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Utilisation de l'application",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "L'application de paiement des frais d'écolage est destinée à faciliter le processus de paiement des frais scolaires par LIAS-PAY. Vous acceptez d'utiliser cette application uniquement à des fins légales et conformément aux politiques de l'école.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Confidentialité et sécurité",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Nous accordons une grande importance à la confidentialité de vos informations personnelles. Nous collectons, utilisons et protégeons vos informations conformément à notre Politique de Confidentialité. Vous reconnaissez et acceptez que nous ne partagerons pas vos informations personnelles avec des tiers, sauf dans les cas nécessaires pour fournir les services demandés, pour respecter les obligations légales ou pour protéger nos droits, notre sécurité ou notre propriété.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Responsabilité",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "L'utilisation de cette application est à vos propres risques. Nous ne pouvons garantir la disponibilité ininterrompue de l'application ni l'absence d'erreurs ou de bugs. Nous déclinons toute responsabilité quant aux dommages directs, indirects, spéciaux ou consécutifs découlant de l'utilisation de cette application.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Modifications des Termes et Conditions",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Nous nous réservons le droit de modifier ces Termes et Conditions à tout moment. Toute modification prendra effet dès sa publication dans l'application. Il est de votre responsabilité de consulter régulièrement les Termes et Conditions pour rester informé des mises à jour.",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Contact",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Si vous avez des questions ou des préoccupations concernant ces Termes et Conditions, veuillez nous contacter à info@lkmdigital.ci .",
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox(
                height: 50,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
