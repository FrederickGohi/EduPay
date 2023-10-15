import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../constantes/constantes.dart';
import '../../../widgets/info_message.dart';
import '../api/api.dart';
import '../views/login/login.dart';

class NewPassword extends StatefulWidget {
  final String email;
  const NewPassword({super.key, required this.email});

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool isObscurityText = true;
  bool isPassword = false;

  void passwordRestore() async {
    try {
      var response = await http.post(
        Uri.parse(Api.newPassword),
        body: {
          'email': widget.email.toString(),
          'password': _confirmPasswordController.text,
        },
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['success']) {
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();
          InfoMessage.snackbar(Get.context!, 'Mot de passe modifié');
          Get.offAll(() => const Login());
        } else {}
        if (kDebugMode) {
          print(responseBody['data']);
        }
      } else {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
        InfoMessage.snackbar(Get.context!, 'Echec de la connexion');
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
      floatingActionButton: Container(
          height: MediaQuery.of(context).size.height * 0.055,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: Theme.of(context).buttonTheme.colorScheme!.primaryContainer,
            borderRadius: BorderRadius.circular(20.0),
            border: const Border.fromBorderSide(BorderSide.none),
          ),
          child: InkWell(
            onTap: () {
              if (_formKey.currentState!.validate()) {
                // valider();
                showDialog(
                    context: context,
                    builder: (context) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    });
                // Future.delayed(
                //     Duration(milliseconds: 1500), () {
                // Navigator.of(context).pop();
                // checkEmail();
                passwordRestore();
                // });
              }
            },
            child: const Center(
              child: AutoSizeText(
                "ENREGISTRER",
                // style:Theme.of(context).textTheme.titleLarge,
                style: TextStyle(
                    letterSpacing: 1.0,
                    fontSize: 14.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: const Text("Changement mot de passe"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(
                      Radius.circular(Dimensions.CardProduitRaduis)),
                  child: Image.asset(
                    "assets/images/auth_pass.png",
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.3,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              AutoSizeText(
                "Nouveau mot de passe",
                style: Theme.of(context).textTheme.titleLarge,
                // TextStyle(
                //   fontSize: 30,
                //   // fontWeight: FontWeight.bold,
                // ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              TextFormField(
                controller: _newPasswordController,
                obscureText: isObscurityText,
                //inputFormatters: [WhitelistingTextInputFormatter(RegExp(r'[a-zA-Z0-9]'))],
                // keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  hintText: 'Ex: *******',
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
                  labelText: "Nouveau mot de passe",
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(style: BorderStyle.solid)),
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
                    return 'Veuillez saisir un nouveau mot de passe';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: _confirmPasswordController,
                obscureText: isObscurityText,
                //inputFormatters: [WhitelistingTextInputFormatter(RegExp(r'[a-zA-Z0-9]'))],
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
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
                  labelText: "Confirmez le nouveau mot de passe",
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(style: BorderStyle.solid)),
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
                    return 'Veuillez confirmer le nouveau mot de passe';
                  } else if (value != _newPasswordController.text) {
                    return 'Les mots de passe ne correspondent pas';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
