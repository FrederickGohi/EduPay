import 'dart:convert';
import 'dart:developer';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:quickalert/quickalert.dart';
import '../../api/api.dart';
import '../../constantes/constantes.dart';
import '../../models/user.dart';
import '../../widgets/event_pref.dart';
import '../../widgets/info_message.dart';
import '../../widgets/root.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nomController = TextEditingController();
  final _prenomsController = TextEditingController();
  final _emailController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool isPhone = false;
  bool isPassword = false;
  bool isPasswordConfirm = false;
  bool isNom = false;
  bool isPrenoms = false;
  bool isEmail = false;
  bool isEmailConfirm = false;
  bool isObscurityText = true;

  bool isLoading = false;

  void _onSubmit() {
    setState(() => isLoading = true);
    Future.delayed(
      const Duration(seconds: 1),
      () => setState(() {
        // isLoading = false;
        checkEmail();
      }),
    );
  }

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

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
          Get.offAll(() => const Root());

          // });
        } else {
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

  void checkEmail() async {
    try {
      var response = await http.post(
        Uri.parse(Api.checkEmail),
        body: {
          'email': _emailController.text,
        },
      );

      if (response.statusCode == 200) {
        inspect(response.body);
        var responseBody = jsonDecode(response.body);
        if (responseBody['exist']) {
          // ignore: use_build_context_synchronously
          QuickAlert.show(
            context: context,
            title: 'Echec',
            type: QuickAlertType.warning,
            text: "L'e-mail saisie existe déjà",
            confirmBtnColor: Theme.of(context).buttonTheme.colorScheme!.primary,
          );

          setState(() {
            isLoading = false;
          });
        } else {
          register();
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void register() async {
    User user = User(
      1,
      _nomController.text,
      _prenomsController.text,
      _emailController.text,
      _phoneController.text,
      _passwordController.text,
    );
    try {
      var response = await http.post(
        Uri.parse(Api.register),
        body: user.toJson(),
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          await EventPref.saveUser(user);

          // ignore: use_build_context_synchronously
          QuickAlert.show(
            context: context,
            type: QuickAlertType.success,
            text: 'Inscription réussie !',
            confirmBtnText: 'Continuer',
            // ignore: use_build_context_synchronously
            confirmBtnColor: Theme.of(context).buttonTheme.colorScheme!.primary,
            onConfirmBtnTap: () {
              login();
            },
          );

          setState(() {
            isLoading = false;
          });
        } else {
          InfoMessage.snackbar(Get.context!, "Echec d'enregistrement");
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        bottomOpacity: 0,
        title: const Text(
          "Inscription",
          style: TextStyle(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 25),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // height: 80,
                  TextFormField(
                    controller: _nomController,
                    //inputFormatters: [WhitelistingTextInputFormatter(RegExp(r'[a-zA-Z0-9]'))],
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: 'Ex: KOUAKOU',
                      prefixIcon: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                          child: Icon(
                            Icons.person_add_alt,
                          )),
                      labelText: "Entrez votre nom",
                      filled: true,
                      // fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            style: BorderStyle.solid,
                          )),
                      labelStyle: const TextStyle(
                        fontSize: 15,
                        // color: Colors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Couleurs.ButtonCouleur,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez saisir votre nom';
                      }
                      return null;
                    },
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  TextFormField(
                    controller: _prenomsController,
                    //inputFormatters: [WhitelistingTextInputFormatter(RegExp(r'[a-zA-Z0-9]'))],
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                      hintText: 'Ex: Albert',
                      prefixIcon: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                          child: Icon(
                            Icons.person_add_alt,
                          )),
                      labelText: "Entrez votre prénom",
                      filled: true,
                      // fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              const BorderSide(style: BorderStyle.solid)),
                      labelStyle: const TextStyle(
                        fontSize: 15,
                        // color: Colors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Couleurs.ButtonCouleur,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez saisir votre prenom';
                      }
                      return null;
                    },
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  IntlPhoneField(
                    controller: _phoneController,
                    initialCountryCode: 'CI',
                    decoration: InputDecoration(
                      filled: true,
                      hintText: 'Numéro de téléphone',
                      hintStyle: const TextStyle(
                        fontSize: 16,
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Couleurs.ButtonCouleur,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  TextFormField(
                    controller: _emailController,
                    //inputFormatters: [WhitelistingTextInputFormatter(RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))],
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      hintText: 'Ex: abc@exemple.ci',
                      prefixIcon: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                          child: Icon(
                            Icons.email,
                          )),
                      labelText: "Entrez votre E-mail",
                      filled: true,
                      // fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              const BorderSide(style: BorderStyle.solid)),
                      labelStyle: const TextStyle(
                        fontSize: 15,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Couleurs.ButtonCouleur,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez saisir votre e-mail';
                      }
                      return null;
                    },
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),

                  TextFormField(
                    controller: _passwordController,
                    obscureText: isObscurityText,
                    decoration: InputDecoration(
                      hintText: 'Ex: ******',
                      prefixIcon: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        child: Icon(
                          Icons.lock,
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
                              ),
                              child: const Icon(
                                Icons.remove_red_eye_outlined,
                              ),
                            ),
                          )),
                      labelText: "Entrez votre mot de passe",
                      filled: true,
                      // fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              const BorderSide(style: BorderStyle.solid)),
                      labelStyle: const TextStyle(
                        fontSize: 15,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Couleurs.ButtonCouleur,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez saisir un mot de passe';
                      }
                      return null;
                    },
                  ),

                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: isObscurityText,
                    //inputFormatters: [WhitelistingTextInputFormatter(RegExp(r'[a-zA-Z0-9]'))],
                    keyboardType: TextInputType.visiblePassword,
                    decoration: InputDecoration(
                      // hintText: 'Ex: *******',
                      prefixIcon: const Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                          child: Icon(
                            Icons.lock,
                          )),
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
                              ),
                              child: const Icon(
                                Icons.remove_red_eye_outlined,
                              ),
                            ),
                          )),
                      labelText: "Confirmez le mot de passe",
                      filled: true,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide:
                              const BorderSide(style: BorderStyle.solid)),
                      labelStyle: const TextStyle(
                        fontSize: 15,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        borderSide: const BorderSide(
                          width: 1,
                          color: Couleurs.ButtonCouleur,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Veuillez confirmer nouveau mot de passe';
                      } else if (value != _passwordController.text) {
                        return 'Les mots de passe ne correspondent pas';
                      }
                      return null;
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.07,
                  ),
                  Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .buttonTheme
                            .colorScheme!
                            .primaryContainer,
                        borderRadius: BorderRadius.circular(20.0),
                        border: const Border.fromBorderSide(BorderSide.none),
                      ),
                      child: InkWell(
                        onTap: (() {
                          if (_formKey.currentState!.validate()) {
                            isLoading ? null : _onSubmit();
                          }
                        }),
                        child: isLoading
                            ? Center(
                                child: Container(
                                  width: 24,
                                  height: 24,
                                  padding: const EdgeInsets.all(2.0),
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3,
                                  ),
                                ),
                              )
                            : const Center(
                                child: AutoSizeText(
                                  "S'inscrire",
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    // (isPasswordConfirm && isEmailConfirm && isPassword && isPhone && isEmail && isNom && isPrenoms)?Colors.white:Colors.grey,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
