import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../../widgets/info_message.dart';
import '../api/api.dart';
import '../constantes/constantes.dart';
import 'newPassword.dart';
import 'package:random_string/random_string.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _ForgetPasswordPage createState() => _ForgetPasswordPage();
}

class _ForgetPasswordPage extends State<ForgetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool isEmail = false;
  bool _isEmailValid = false;
  bool isPassword = false;
  bool isObscurityText = true;

  String? codeOTP;
  bool isCodeOTP = false;
  bool stepOne = true;

  @override
  void initState() {
    super.initState();
  }

  void onChangeCode(String code) {
    if (code == codeOTP) {
      setState(() {
        isCodeOTP = true;
      });
    } else {
      setState(() {
        isCodeOTP = false;
      });
    }
  }

  renvoyerCodeOTP() {
    setState(() {
      codeOTP = randomNumeric(6);
    });
    return codeOTP;
  }

  void valider() {
    setState(() {
      // renvoyerCodeOTP();
      // stepOne = false;
      codeOTP = randomNumeric(6);
    });
    checkEmail(codeOTP);
  }

  void checkEmail(var otp) async {
    try {
      var response = await http.post(
        Uri.parse(Api.passwordRecovery),
        body: {
          'email': _emailController.text,
          'otp': otp,
        },
      );

      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['exist']) {
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();
          setState(() {
            stepOne = false;
          });
        } else {
          // ignore: use_build_context_synchronously
          Navigator.of(context).pop();
          InfoMessage.snackbar(
              Get.context!, 'Aucun compte lié à cette adresse !');
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
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: Visibility(
        visible: stepOne,
        replacement: Container(
            height: Get.height * 0.055,
            width: Get.width * 0.9,
            decoration: BoxDecoration(
              color: (isCodeOTP)
                  ? Theme.of(context).buttonTheme.colorScheme!.primaryContainer
                  : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20.0),
              border: const Border.fromBorderSide(BorderSide.none),
            ),
            child: InkWell(
              onTap: () {
                (isCodeOTP)
                    ? Get.to(
                        () => NewPassword(email: _emailController.text),
                      )
                    : null;
              },
              child: Center(
                child: AutoSizeText(
                  "CONTIUNER",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                    color: (isCodeOTP) ? Colors.white : Colors.grey,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )),
        child: Container(
            height: Get.height * 0.055,
            width: Get.width * 0.9,
            decoration: BoxDecoration(
              color:
                  Theme.of(context).buttonTheme.colorScheme!.primaryContainer,
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
                  valider();
                  // });
                }
              },
              child: const Center(
                child: AutoSizeText(
                  "VERIFIER",
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        // backgroundColor: Couleurs.CouleurSecondaire,
        centerTitle: true,
        elevation: 0,
        bottomOpacity: 0,
        title: const Text(
          "Mot de passe oublié",
          style: TextStyle(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // formulaire enregistrement
            SizedBox(
              width: size.width,
              height: size.height,
              /*0.786*/
              child: SingleChildScrollView(
                child: Visibility(
                  visible: stepOne,
                  replacement: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: Dimensions.MobileMargin + 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(Dimensions.CardProduitRaduis)),
                            child: Image.asset(
                              "assets/images/auth_pass.png",
                              height: MediaQuery.of(context).size.height * 0.2,
                              width: MediaQuery.of(context).size.width * 0.5,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const AutoSizeText(
                          "Vérification",
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                          minFontSize: 20,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        AutoSizeText(
                          "Entrez le code OTP envoyé sur votre email ( ${_emailController.text})",
                          style:
                              const TextStyle(fontSize: 14, color: Colors.grey),
                          textAlign: TextAlign.center,
                          minFontSize: 13,
                          maxLines: 7,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        SizedBox(
                          height: 60,
                          child: TextFormField(
                            controller: _codeController,
                            onEditingComplete: () {
                              setState(() {
                                _codeController.text =
                                    _codeController.text.toString().trim();
                              });
                            },
                            onChanged: (txt) {
                              onChangeCode(txt);
                            },
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                  RegExp(r'[0-9]'))
                            ],
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Entrez le code OTP',
                              prefixIcon: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 15),
                                child: Icon(
                                  Icons.qr_code,
                                ),
                              ),
                              labelText: "Ex: 123456",
                              filled: true,
                              // fillColor: Colors.white,
                              labelStyle: const TextStyle(
                                fontSize: 15,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: const BorderSide(
                                      style: BorderStyle.solid)),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                borderSide: const BorderSide(
                                  width: 1,
                                  color: Couleurs.CouleurSecondaire,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // SizedBox(
                        //   height: 10,
                        // ),
                        Row(
                          // textDirection: ,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Vous n'avez pas reçu le code ?"),
                            TextButton(
                              onPressed: () {},
                              child: const Text(
                                "Renvoyer",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: Dimensions.MobileMargin),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/auth_pass.png",
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.5,
                          ),

                          const AutoSizeText(
                            "Entrez votre E-mail de recupération",
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                            minFontSize: 17,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05,
                          ),
                          // AutoSizeText(
                          //   "Entrez votre E-mail de recupération.",
                          //   style: TextStyle(
                          //     fontSize: 14,
                          //     color: Colors.grey,
                          //   ),
                          //   textAlign: TextAlign.center,
                          //   minFontSize: 13,
                          //   maxLines: 7,
                          //   overflow: TextOverflow.ellipsis,
                          // ),

                          //email
                          TextFormField(
                            controller: _emailController,
                            onChanged: (text) {
                              setState(() {
                                _isEmailValid =
                                    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                                        .hasMatch(text.trim());
                              });
                            },
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: 'Ex: email@example.com',
                              prefixIcon: const Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 15, horizontal: 8),
                                child: Icon(
                                  Icons.email_outlined,
                                ),
                              ),
                              labelText: "Email",
                              // fillColor: Colors.white,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  style: BorderStyle.none,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Colors.redAccent,
                                  width: 1.0,
                                ),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Colors.redAccent,
                                  width: 1.0,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                  width: 1.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: const BorderSide(
                                  color: Couleurs.CouleurSecondaire,
                                  width: 1.0,
                                ),
                              ),
                              suffixIcon: _isEmailValid
                                  ? const Icon(
                                      Icons.check_circle_outline,
                                      color: Colors.green,
                                    )
                                  : const Icon(
                                      Icons.error_outline,
                                      color: Colors.redAccent,
                                    ),
                            ),
                            validator: (value) {
                              if (!_isEmailValid) {
                                return 'Veuillez saisir une adresse e-mail valide';
                              }
                              return null;
                            },
                          ),
                          //boutton validation
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
