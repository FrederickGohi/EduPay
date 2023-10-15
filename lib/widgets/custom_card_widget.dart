import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class CustomCardWidget extends StatelessWidget {
  final String imageAssetPath; // Champ pour le chemin de l'image asset
  final String title;
  final double iconSize;
  final double titleFontSize;
  final Function()? onTap;

  const CustomCardWidget({
    Key? key,
    required this.imageAssetPath, // Ajout du chemin de l'image asset
    required this.title,
    this.iconSize = 50.0,
    this.titleFontSize = 15.0,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      elevation: 8,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: size.width * 0.2,
          height: size.height * 0.2,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset( // Utilisation de Image.asset pour afficher l'image depuis l'asset
                imageAssetPath, // Utilisation du chemin de l'image asset
                width: size.width * 0.2, // Vous pouvez ajuster la taille de l'image
              ),
              SizedBox(height: size.height * 0.03),
              AutoSizeText(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: titleFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
