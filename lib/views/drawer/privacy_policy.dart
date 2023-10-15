import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Couleurs.CouleurSecondaire,
        title: const Text("Politique de confidentialité"),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20, top: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "LKM DIGITAL a développé l'application LIA-PAY en tant qu'application commerciale. Ce SERVICE est fourni par LKM DIGITAL et est destiné à être utilisé tel quel. Cette page est utilisée pour informer les visiteurs de nos politiques en matière de collecte, d'utilisation et de divulgation des informations personnelles si quelqu'un décide d'utiliser notre service.\n\nSi vous choisissez d'utiliser notre service, vous acceptez la collecte et l'utilisation d'informations en relation avec cette politique. Les informations personnelles que nous collectons sont utilisées pour fournir et améliorer le service. Nous n'utiliserons ni ne partagerons vos informations avec qui que ce soit, sauf de la manière décrite dans la présente politique de confidentialité.Les termes utilisés dans la présente politique de confidentialité ont la même signification que dans nos conditions générales, qui sont accessibles sur LIA-PAY, sauf indication contraire dans la présente politique de confidentialité.",
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Collecte et utilisation des informations",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Pour une meilleure expérience, lors de l'utilisation de notre service, nous pouvons vous demander de nous fournir certaines informations personnellement identifiables, y compris, mais sans s'y limiter, JP Lasme. Les informations que nous demandons seront conservées par nous et utilisées comme décrit dans cette politique de confidentialité.\nL'application utilise des services tiers qui peuvent collecter des informations utilisées pour vous identifier.\n\n\nNous souhaitons vous informer que chaque fois que vous utilisez notre service, en cas d'erreur dans l'application, nous collectons des données et des informations (via des produits tiers) sur votre téléphone, appelées données de journal. Ces données de journal peuvent inclure des informations telles que l'adresse de protocole Internet ('IP') de votre appareil, le nom de l'appareil, la version du système d'exploitation, la configuration de l'application lors de l'utilisation de notre service, l'heure et la date de votre utilisation du service et d'autres statistiques.",
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Cookies",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Les cookies sont des fichiers contenant une petite quantité de données qui sont couramment utilisés comme identifiants uniques anonymes. Ceux-ci sont envoyés à votre navigateur à partir des sites Web que vous visitez et sont stockés dans la mémoire interne de votre appareil.\n\nCe Service n'utilise pas explicitement ces « cookies ». Cependant, l'application peut utiliser du code tiers et des bibliothèques qui utilisent des 'cookies' pour collecter des informations et améliorer leurs services. Vous avez la possibilité d'accepter ou de refuser ces cookies et de savoir quand un cookie est envoyé sur votre appareil. Si vous choisissez de refuser nos cookies, vous ne pourrez peut-être pas utiliser certaines parties de ce Service.",
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Les fournisseurs de services :',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Nous pouvons faire appel à des sociétés tierces et à des particuliers pour les raisons suivantes :\n\nPour faciliter notre Service ;\nPour fournir le Service en notre nom ;\nPour effectuer des services liés au Service pour nous aider à analyser comment notre Service est utilisé.\n\nNous souhaitons informer les utilisateurs de ce Service que ces tiers ont accès à leurs Informations personnelles. La raison est d'accomplir les tâches qui leur sont confiées en notre nom. Cependant, ils sont tenus de ne pas divulguer ou utiliser les informations à d'autres fins.",
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'Securité :',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Nous apprécions votre confiance en nous fournissant vos informations personnelles, nous nous efforçons donc d'utiliser des moyens commercialement acceptables pour les protéger. Mais n'oubliez pas qu'aucune méthode de transmission sur Internet ou méthode de stockage électronique n'est sûre et fiable à 100 %, et nous ne pouvons garantir sa sécurité absolue.",
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Liens vers d'autres sites :",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Ce Service peut contenir des liens vers d'autres sites. Si vous cliquez sur un lien tiers, vous serez dirigé vers ce site. Notez que ces sites externes ne sont pas exploités par nous. Par conséquent, nous vous conseillons vivement de consulter la politique de confidentialité de ces sites Web. Nous n'avons aucun contrôle et n'assumons aucune responsabilité quant au contenu, aux politiques de confidentialité ou aux pratiques des sites ou services tiers.",
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Confidentialité des enfants",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Ces Services ne s'adressent à personne de moins de 13 ans. Nous ne collectons pas sciemment d'informations personnellement identifiables auprès d'enfants de moins de 13 ans. Dans le cas où nous découvrons qu'un enfant de moins de 13 ans nous a fourni des informations personnelles, nous les supprimons immédiatement de nos serveurs. Si vous êtes un parent ou un tuteur et que vous savez que votre enfant nous a fourni des informations personnelles, veuillez nous contacter afin que nous puissions faire les actions nécessaires.",
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Modifications de cette politique de confidentialité",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Nous pouvons mettre à jour notre politique de confidentialité de temps à autre. Ainsi, il vous est conseillé de consulter cette page périodiquement pour tout changement. Nous vous informerons de tout changement en publiant la nouvelle politique de confidentialité sur cette page.\n\nCette politique est effective à partir du 29-06-2023",
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.justify,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Nous contacter",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Si vous avez des questions ou des suggestions concernant notre politique de confidentialité, n'hésitez pas à nous contacter à infos@lkmdigital.ci.",
                style: TextStyle(fontSize: 15),
                textAlign: TextAlign.justify,
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
