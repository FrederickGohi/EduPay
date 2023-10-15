import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Echec extends StatefulWidget {
  const Echec({super.key});

  @override
  State<Echec> createState() => _EchecState();
}

class _EchecState extends State<Echec> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
          height: MediaQuery.of(context).size.height * 0.055,
          width: Get.width * 0.9,
          decoration: BoxDecoration(
            color: Theme.of(context).buttonTheme.colorScheme!.primary,
            borderRadius: BorderRadius.circular(20.0),
            border: const Border.fromBorderSide(BorderSide.none),
          ),
          child: InkWell(
              onTap: () {
                // Get.back;
                Navigator.pop(context);
              },
              child: Center(
                child: AutoSizeText(
                  "Réessayer".toUpperCase(),
                  style: const TextStyle(
                    fontSize: 14.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ))),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: const Text(
          "ECHEC DE PAIEMENT",
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        // centerTitle: true,
        leading: Image(
          image: const AssetImage("assets/images/logo.png"),
          width: Get.width,
          height: Get.height,
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 100,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Oups ! \nLe paiement a échoué.',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Une erreur s\'est produite lors du traitement de votre paiement. Veuillez vérifier vos informations et réessayer, ou contactez notre support pour obtenir de l\'aide.',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
