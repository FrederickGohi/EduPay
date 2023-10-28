import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:quickalert/quickalert.dart';

import '../../api/api.dart';
import '../../constantes/constantes.dart';
import '../../models/user.dart';
import '../../mot_de_passe_oublier/ForgetPassword.dart';
import '../../widgets/event_pref.dart';
import '../../widgets/info_message.dart';
import '../../widgets/root.dart';
import 'register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool isPhone = false;
  bool isPassword = false;
  bool isObscurityText = true;
  bool isLoading = false;

  void _onSubmit() {
    setState(() => isLoading = true);
    Future.delayed(
      const Duration(seconds: 2),
      () => setState(() {
        // isLoading = false;
        login();
      }),
    );
  }

  final _formKey = GlobalKey<FormState>();

  void login() async {
    try {
      var response = await http.post(
        Uri.parse(Api.login),
        body: {
          'email': _emailController.text,
          'password': _passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          InfoMessage.snackbar(Get.context!, 'Connecté(e)');
          User user = User.fromJson(responseBody['data']);
          await EventPref.saveUser(user);
          // Future.delayed(Duration(milliseconds: 1500), () {
          Get.offAll(() => const Root());
          // });
        } else {
          // ignore: use_build_context_synchronously
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            title: 'Erreur',
            text: 'Email ou mot de passe incorrect(s)',
          );
          setState(() {
            isLoading = false;
          });
        }
        print(responseBody['data']);
      } else {
        InfoMessage.snackbar(Get.context!, 'Echec de la connexion');
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        // backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
              child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Image(
                  image: const AssetImage("assets/images/logo_.png"),
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.15,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Center(
                    child: AutoSizeText(
                      "EduPay",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 23,
                          color: Color.fromRGBO(22, 45, 77, 1),
                          fontFamily: 'Raleway'),
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: 'Ex: email@email.com',
                    prefixIcon: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                      child: Icon(
                        Icons.email_outlined,
                      ),
                    ),
                    labelText: "Email",
                    // fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(style: BorderStyle.solid)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                        // width: 1,
                        color: Couleurs.ButtonCouleur,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez saisir votre adresse email';
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                TextFormField(
                  controller: _passwordController,
                  obscureText: isObscurityText,
                  decoration: InputDecoration(
                    hintText: "Ex: ******",
                    prefixIcon: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Icon(
                        Icons.lock,
                        // color: Couleurs.ButtonCouleur,
                      ),
                    ),
                    suffixIcon: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              isObscurityText = !isObscurityText;
                            });
                          },
                          icon: Visibility(
                            visible: isObscurityText,
                            replacement: const Icon(
                              Icons.visibility_off,
                              // color: Couleurs.ButtonCouleur,
                            ),
                            child: const Icon(
                              Icons.remove_red_eye_outlined,
                              // color: Couleurs.ButtonCouleur,
                            ),
                          ),
                        )),
                    labelText: "Mot de passe",
                    // fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(style: BorderStyle.solid)),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: const BorderSide(
                        // color: Couleurs.ButtonCouleur,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez saisir votre mot de passe';
                    }
                    return null;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        // Get.to(() => const ForgetPasswordPage());
                      },
                      child: const AutoSizeText(
                        "Mot de passe oublié ?",
                        style: TextStyle(
                          fontSize: 14.0,
                          // color: Couleurs.ButtonCouleur,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.02,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.offAll(() => const Root());
                    // if (_formKey.currentState!.validate()) {
                    //     isLoading ? null : _onSubmit();
                    //   }
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
                  child: isLoading
                      ? Center(
                          child: Container(
                            width: size.width * 0.06,
                            height: size.height * 0.03,
                            padding: const EdgeInsets.all(2.0),
                            child: CircularProgressIndicator(
                              color: Theme.of(context)
                                  .buttonTheme
                                  .colorScheme!
                                  .onPrimary,
                              strokeWidth: 3,
                            ),
                          ),
                        )
                      :  Text(
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const AutoSizeText(
                      "Vous n'avez pas de compte ?",
                      style: TextStyle(
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                      minFontSize: 13,
                      maxLines: 7,
                      overflow: TextOverflow.ellipsis,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.to(() => const Register());
                      },
                      child: const AutoSizeText(
                        "Inscription",
                        textAlign: TextAlign.center,
                        minFontSize: 13,
                        maxLines: 7,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
              ],
            ),
          ),
              ),
            ),
        ));
  }
}
