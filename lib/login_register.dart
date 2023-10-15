import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:edupay/views/login/login.dart';
import 'package:edupay/views/login/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// import 'constantes/config.dart';

class LoginRegister extends StatelessWidget {
  const LoginRegister({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/univ.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            height: size.height,
            width: size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                stops: [0.3, 1],
                colors: [
                  Color.fromARGB(
                      255, 255, 191, 29), // Couleur avec opacité totale
                  Color.fromARGB(200, 255, 255,
                      255), // Couleur avec une opacité réduite (128)
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Center(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                       const SizedBox(
                        height: 50,
                      ),
                      Container(
                        height: size.width / 5,
                        width: size.width / 5,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("assets/images/logo.png"),
                              fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: size.width * 0.9,
                        child: const Text(
                          textAlign: TextAlign.center,
                          "EduPay",
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  ),

                  AnimatedTextKit(
                    animatedTexts: [
                      // TyperAnimatedText('This is Animated text,',
                      //     textStyle: const TextStyle(
                      //         color: Colors.white,
                      //         fontSize: 30,
                      //         backgroundColor: Colors.purple)),
                      TyperAnimatedText(
                          'Payez vos frais scolaires sans vous déplacer',
                          textStyle: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center),
                    ],
                    onTap: () {
                      print("I am executing");
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Get.to(() => const Login());
                          },
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(
                              Size(MediaQuery.of(context).size.width, 55),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context)
                                  .buttonTheme
                                  .colorScheme!
                                  .primary,
                            ), //verifier si la couleur est nul (si oui alors on lui donne la couleur pas defaut)
                          ),
                          child: Text(
                            'Connexion',
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context)
                                  .buttonTheme
                                  .colorScheme!
                                  .onPrimary,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Get.to(() => const Register());
                          },
                          style: ButtonStyle(
                            fixedSize: MaterialStateProperty.all(
                              Size(MediaQuery.of(context).size.width, 55),
                            ),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              Theme.of(context)
                                  .buttonTheme
                                  .colorScheme!
                                  .primaryContainer,
                            ), //verifier si la couleur est nul (si oui alors on lui donne la couleur pas defaut)
                          ),
                          child: Text(
                            'inscription',
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context)
                                  .buttonTheme
                                  .colorScheme!
                                  .onPrimary,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
// CButton(title: "Connexion", onPressed: () {})
