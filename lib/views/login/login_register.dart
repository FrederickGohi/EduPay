import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constantes/constantes.dart';
import 'login.dart';
import 'register.dart';

class LoginRegister extends StatefulWidget {
  const LoginRegister({super.key});

  @override
  State<LoginRegister> createState() => _LoginRegisterState();
}

class _LoginRegisterState extends State<LoginRegister> {
  final List<String> imgList = [
    'assets/images/accueil1.jpg',
    'assets/images/accueil2.jpg',
    'assets/images/accueil3.jpg',
    'assets/images/accueil4.jpg',
  ];

  final PageController _pageController =
      PageController(viewportFraction: 0.8, initialPage: 1);

  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final width = screenSize.width / 3;
    final height = screenSize.height / 18;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Pour le paiement de vos frais d'écolage ...",
          style: TextStyle(
              color: Couleurs.CouleurSecondaire,
              fontSize: 14,
              fontStyle: FontStyle.italic),
        ),
        // centerTitle: true,
        backgroundColor: Colors.white,
        leading: Image(
          image: const AssetImage("assets/images/logo.png"),
          width: Get.width,
          height: Get.height,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 1.0,
              enlargeCenterPage: true,
              // viewportFraction: 1,
              autoPlayInterval: const Duration(seconds: 3),
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              },
            ),
            items: imgList
                .map((item) => Container(
                      margin: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(5.0)),
                          child: Stack(
                            children: <Widget>[
                              Image.asset(
                                item,
                                fit: BoxFit.fill,
                                height: Get.height,
                                width: Get.width,
                              ),
                            ],
                          )),
                    ))
                .toList(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : Couleurs.CouleurSecondaire)
                          .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              InkWell(
                onTap: () {
                  Get.to(() => const Login());
                },
                child: Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Center(
                    child: Text(
                      'CONNEXION',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16 * Get.textScaleFactor,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  Get.to(() => const Register());
                },
                child: Container(
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                      // color: Couleurs.CouleurSecondaire,
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.outline,
                      )),
                  child: Center(
                    child: Text(
                      'INSCRIPTION',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.shadow,
                        fontWeight: FontWeight.bold,
                        fontSize: 16 * MediaQuery.of(context).textScaleFactor,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.05,
          ),
          Column(
            children: [
              Text(
                'scolarite@ensit.ci',
                style: Theme.of(context).textTheme.titleMedium
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              Text(
                '+225 27 22 41 65 63 ',
                style: Theme.of(context).textTheme.titleMedium
              ),
            ],
          ),
        ],
      ),
    );
  }
}
