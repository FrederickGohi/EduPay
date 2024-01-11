import 'dart:developer';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:edupay/api/api.dart';
import 'package:edupay/views/Services/mtn_webhook.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../constantes/constantes.dart';
import '../controllers/c_user.dart';
import '../modelss/matricule.dart';
import '../widgets/info_message.dart';
import 'package:http/http.dart' as http;

class PaymentProcessing extends StatefulWidget {
  final List<Matricule> matricules;
  final ecole;
  final idecole;

  const PaymentProcessing(
      {super.key,
      required this.matricules,
      required this.ecole,
      required this.idecole});

  @override
  State<PaymentProcessing> createState() => _PaymentProcessingState();
}

class _PaymentProcessingState extends State<PaymentProcessing> {
  int currentStep = 0;
  final TextEditingController _montantController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();

  final _cUser = Get.put(CUser());

  final formatter = NumberFormat.currency(locale: 'fr_XOF', symbol: 'XOF');

  final _formKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();

  bool isMontantValid = false;
  String montantError = '';

  String service = "";
  bool isLoading = false;

  var tel;

  late Matricule selectedMatricule;

  void updateMontantValidation(String value) {
    if (value.isEmpty) {
      montantError = 'Veuillez saisir un montant';
      isMontantValid = false;
    } else {
      var v = value.replaceAll(RegExp(r"\s+"), "");
      var montant = int.tryParse(v);
      if (montant == null) {
        montantError = 'Veuillez saisir un montant valide';
        isMontantValid = false;
      } else if (montant <= 99) {
        montantError = 'Le montant minimum est de 100 F';
        isMontantValid = false;
      } else if (montant % 100 != 0) {
        montantError = 'Le montant doit être un multiple de 100';
        isMontantValid = false;
      } else {
        montantError = '';
        isMontantValid = true;
      }
    }
    setState(() {});
  }

  continueStep() {
    if (currentStep < 3) {
      setState(() {
        currentStep = currentStep + 1;
      });
    }
  }

  cancelStep() {
    if (currentStep > 0) {
      setState(() {
        currentStep = currentStep - 1;
      });
    }
  }

  onStepTapped(int value) {
    setState(() {
      currentStep = value;
    });
  }

  Future paymtn(selectedMatricule) async {
    inspect(selectedMatricule);
    var montantText = _montantController.text.replaceAll(' ', '');
    var montant = double.tryParse(montantText) ?? 0.0;
    var pourcentage = 0.02;

    var frais = (montant * pourcentage).round();

    var total = montant + frais;
    var montant_total = total.round();

    var frais_op = double.tryParse(montantText) ?? 0.0;
    var pourcentage_operator = 0.01;
    var frais_operateur = (frais_op * pourcentage_operator).round();

    try {
      var response = await http.post(
        Uri.parse(Api.pay),
        body: {
          'id_user': '${_cUser.user.id_user}',
          'nom_parent': '${_cUser.user.nom} ${_cUser.user.prenom}',
          'telephone': tel,
          'email': _cUser.user.email,
          'schoolid': "${widget.idecole}",
          'nom_eleve': '${selectedMatricule.nom}',
          'prenom_eleve': '${selectedMatricule.prenom}',
          'date_naissance': '${selectedMatricule.date_naissance}',
          'lieu_naissance': '${selectedMatricule.lieu_naissance}',
          'classe': '${selectedMatricule.classe}',
          'ecole': '${widget.ecole}',
          'matricule': '${selectedMatricule.matricule}',
          'montant_initial': _montantController.text.toString(),
          'frais_operateur': '$frais_operateur',
          'frais_edupay': '$frais_operateur',
          // 'montant': '100',
          'montant': '$montant_total',
          'type': service
        },
      );

      if (response.statusCode == 200) {
        Get.to(() => const AwaitWebhook(), fullscreenDialog: true);
      } else {
        InfoMessage.snackbar(Get.context!, 'Echec de la connexion');
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      isLoading = false;
    });
  }

  void onSubmit() {
    setState(() => isLoading = true);
    Future.delayed(
      const Duration(seconds: 2),
      () => setState(() {
        paymtn(selectedMatricule);
        // payorange();
      }),
    );
  }

  Widget controlBuilders(context, details) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
          // children: [
          //   ElevatedButton(
          //     onPressed: details.onStepContinue,
          //     child: const Text('Next'),
          //   ),
          //   const SizedBox(width: 10),
          //   OutlinedButton(
          //     onPressed: details.onStepCancel,
          //     child: const Text('Back'),
          //   ),
          // ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;

    NumberFormat myFormat = NumberFormat.decimalPattern('eu');
    Size size = MediaQuery.of(context).size;
    var v1 = '1 00';

    var v11 = v1.replaceAll(RegExp(r"\s+"), "");
    var v2 = int.parse(v11);
    var fraisWave = (v2 * 1.5 / 100).ceil();
    var fraisMTN = (v2 * 1.5 / 100).ceil();
    var fraisVISA = (v2 * 2.5 / 100).ceil();
    // var fraisOrange = (v2 * 2 / 100).ceil();

    var fraisEliah = (v2 / 100).ceil();

    var wave = v2 + fraisWave + fraisEliah;
    var mtn = v2 + fraisMTN + fraisEliah;
    // var orange = v2 + fraisOrange + fraisEliah;
    var visa = v2 + fraisVISA + fraisEliah;

    return Scaffold(
        floatingActionButton: currentStep == 0
            ? null
            : currentStep == 1
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ElevatedButton(
                      onPressed: isMontantValid
                          ? () {
                              if (_formKey.currentState!.validate()) {
                                var v = _montantController.text.toString();
                                var v2 = v.replaceAll(RegExp(r"\s+"), "");
                                var montant = int.parse(v2);

                                FocusScope.of(context).unfocus();

                                continueStep();
                              }
                            }
                          : null,
                      style: ButtonStyle(
                        fixedSize: MaterialStateProperty.all(
                          Size(MediaQuery.of(context).size.width, 45),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        backgroundColor: isMontantValid
                            ? MaterialStateProperty.all<Color>(
                                Theme.of(context)
                                    .buttonTheme
                                    .colorScheme!
                                    .primaryContainer,
                              )
                            : MaterialStateProperty.all<Color>(Colors.grey),
                      ),
                      child: Text(
                        'Valider',
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context)
                              .buttonTheme
                              .colorScheme!
                              .onPrimary,
                        ),
                      ),
                    ),
                  )
                : currentStep == 2
                    ? null
                    : currentStep == 3
                        ? Column(
                            children: [
                              Expanded(child: Container()), // Espace extensible
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      isLoading ? null : onSubmit();
                                      // Get.off(() => const AwaitWebhook());
                                    },
                                    style: ButtonStyle(
                                        fixedSize: MaterialStateProperty.all(
                                          Size(
                                              MediaQuery.of(context).size.width,
                                              45),
                                        ),
                                        shape: MaterialStateProperty.all(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                        ),
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                          Theme.of(context)
                                              .buttonTheme
                                              .colorScheme!
                                              .primaryContainer,
                                        )),
                                    child: isLoading
                                        ? Center(
                                            child: Container(
                                              width: Get.width * 0.06,
                                              height: size.height * 0.03,
                                              padding:
                                                  const EdgeInsets.all(2.0),
                                              child:
                                                  const CircularProgressIndicator(
                                                color: Colors.white,
                                                strokeWidth: 3,
                                              ),
                                            ),
                                          )
                                        : Text(
                                            'Passer au paiement',
                                            style: TextStyle(
                                              fontSize: 18,
                                              color: Theme.of(context)
                                                  .buttonTheme
                                                  .colorScheme!
                                                  .onPrimary,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: TextButton(
                                    onPressed: () {
                                      // Votre code ici
                                    },
                                    style: ButtonStyle(
                                      fixedSize: MaterialStateProperty.all(
                                        Size(MediaQuery.of(context).size.width,
                                            45),
                                      ),
                                      shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                    ),
                                    child: const Text(
                                      'Annuler',
                                      style: TextStyle(
                                        fontSize: 18,
                                        // color: Theme.of(context)
                                        //     .buttonTheme
                                        //     .colorScheme!
                                        //     .primaryContainer,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : null,
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        appBar: AppBar(
          title: const Text('EduPay'),
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: height * 0.85,
            child: ListView.builder(
              itemCount: widget.matricules.length,
              itemBuilder: (context, index) {
                Matricule matricule = widget.matricules[index];
                selectedMatricule = matricule;
                return Column(
                  children: [
                    SizedBox(
                      height: height * 0.85,
                      // color: Colors.amber,
                      child: Stepper(
                        elevation: 0,
                        controlsBuilder: controlBuilders,
                        type: StepperType
                            .horizontal, // Changez le type en horizontal
                        onStepTapped: onStepTapped,
                        onStepContinue: continueStep,
                        onStepCancel: cancelStep,
                        currentStep: currentStep,
                        steps: [
                          Step(
                            title: const Text(''),
                            // subtitle: Text('data'),
                            content: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // const Center(
                                  //     child: Text(
                                  //   'Profil',
                                  //   textAlign: TextAlign.center,
                                  // )),
                                  Card(
                                    elevation: 5.0,
                                    margin: const EdgeInsets.all(10.0),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ListTile(
                                            leading: const Icon(Icons.person),
                                            title:
                                                Text('Nom: ${matricule.nom}'),
                                          ),
                                          ListTile(
                                            leading: const Icon(Icons.person),
                                            title: Text(
                                                'Prénom: ${matricule.prenom}'),
                                          ),
                                          ListTile(
                                            leading: const Icon(Icons.school),
                                            title: Text(
                                                'Classe: ${matricule.classe}'),
                                          ),
                                          ListTile(
                                            leading: const Icon(Icons.school),
                                            title:
                                                Text('École: ${widget.ecole}'),
                                          ),
                                          // Ajoutez d'autres informations du profil de l'élève ici
                                        ],
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            continueStep();
                                            setState(() {
                                              service = "Scolarité";
                                            });
                                          },
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15.0)),
                                            elevation: 10.0,
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.20,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.41,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15)),
                                                // color:
                                                //     Colors.white,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Center(
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        // margin: const EdgeInsets
                                                        //         .only(
                                                        //     top: Dimensions
                                                        //         .MobileMargin),

                                                        height: 100,
                                                        width: 100,
                                                        child: Image.asset(
                                                          'assets/images/scolarite.png',
                                                          width: 50,
                                                          height: 50,
                                                        ),
                                                      ),
                                                      // SizedBox(
                                                      //   height: Get
                                                      //           .height *
                                                      //       0.01,
                                                      // ),
                                                      Text(
                                                        'Scolarité',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.04,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )),
                                      GestureDetector(
                                          onTap: () {
                                            continueStep();
                                            setState(() {
                                              service = "Cantine";
                                            });
                                          },
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15.0)),
                                            elevation: 10.0,
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.20,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.41,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15)),
                                                // color:
                                                //     Colors.white,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Center(
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        // margin: const EdgeInsets
                                                        //         .only(
                                                        //     top: Dimensions
                                                        //         .MobileMargin),

                                                        height: 100,
                                                        width: 100,
                                                        child: Image.asset(
                                                          'assets/images/cantine.png',
                                                          width: 50,
                                                          height: 50,
                                                        ),
                                                      ),
                                                      // SizedBox(
                                                      //   height: Get
                                                      //           .height *
                                                      //       0.01,
                                                      // ),
                                                      Text(
                                                        'Cantine',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.04,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                  // SizedBox(
                                  //   height: MediaQuery.of(context).size.height * 0.01,
                                  // ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                          onTap: () {
                                            continueStep();
                                            setState(() {
                                              service = "Transport";
                                            });
                                          },
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15.0)),
                                            elevation: 10.0,
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.20,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.41,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15)),
                                                // color:
                                                //     Colors.white,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Center(
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        // margin: const EdgeInsets
                                                        //         .only(
                                                        //     top: Dimensions
                                                        //         .MobileMargin),

                                                        height: 100,
                                                        width: 100,
                                                        child: Image.asset(
                                                          'assets/images/transport.png',
                                                          width: 50,
                                                          height: 50,
                                                        ),
                                                      ),
                                                      // SizedBox(
                                                      //   height: Get
                                                      //           .height *
                                                      //       0.01,
                                                      // ),
                                                      Text(
                                                        'Transport',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.04,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )),
                                      GestureDetector(
                                          onTap: () {
                                            continueStep();
                                            setState(() {
                                              service = "Extra Scolaire";
                                            });
                                          },
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        15.0)),
                                            elevation: 10.0,
                                            child: Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.20,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.41,
                                              decoration: const BoxDecoration(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15)),
                                                // color:
                                                //     Colors.white,
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(15.0),
                                                child: Center(
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        // margin: const EdgeInsets
                                                        //         .only(
                                                        //     top: Dimensions
                                                        //         .MobileMargin),

                                                        height: 98,
                                                        width: 98,
                                                        child: Image.asset(
                                                          'assets/images/sports.png',
                                                          width: 70,
                                                          height: 70,
                                                        ),
                                                      ),
                                                      // SizedBox(
                                                      //   height: Get
                                                      //           .height *
                                                      //       0.01,
                                                      // ),
                                                      Text(
                                                        'Extra Scolaire',
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .width *
                                                                0.04,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )),
                                    ],
                                  )
                                ]),
                            isActive: currentStep >= 0,
                            state: currentStep >= 0
                                ? StepState.complete
                                : StepState.disabled,
                          ),
                          Step(
                            title: const Text(''),
                            content: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: AutoSizeText(
                                    'Saisissez le montant',
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.titleSmall,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Form(
                                  key: _formKey,
                                  child: ListTile(
                                    title: TextFormField(
                                      autofocus: currentStep >= 1,
                                      controller: _montantController,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        _SpaceFormatter(),
                                      ],
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(fontSize: 30),
                                      decoration: InputDecoration(
                                        hintStyle:
                                            const TextStyle(fontSize: 30),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          borderSide: BorderSide.none,
                                        ),
                                        contentPadding: EdgeInsets.zero,
                                        suffixText: 'F CFA',
                                      ),
                                      validator: (value) {
                                        return value == null || value.isEmpty
                                            ? montantError
                                            : null;
                                      },
                                      onChanged: (value) {
                                        updateMontantValidation(value);
                                      },
                                    ),
                                    subtitle: Text(
                                      montantError,
                                      style: const TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            isActive: currentStep >= 1,
                            state: currentStep >= 1
                                ? StepState.complete
                                : StepState.disabled,
                          ),
                          Step(
                            title: const Text(''),
                            content: Column(
                              children: [
                                Card(
                                  elevation: 8,
                                  child: InkWell(
                                    onTap: () {
                                      var phone = _cUser.user.telephone;
                                      String phoneNumber = phone.substring(4);

                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: Column(
                                              children: [
                                                Text(
                                                  'Ce numéro est-il correct ?',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .titleSmall,
                                                ),
                                                const SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  "Assurez-vous d'entrer un numéro MTN",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall,
                                                ),
                                              ],
                                            ),
                                            content: TextFormField(
                                              decoration: InputDecoration(
                                                // hintText: "${_cUser.user.telephone}",
                                                labelText: "Numéro de tél.",
                                                filled: true,
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    borderSide:
                                                        const BorderSide(
                                                            style: BorderStyle
                                                                .solid)),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  borderSide: const BorderSide(
                                                      color: Colors.grey),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  borderSide:
                                                      const BorderSide(),
                                                ),
                                              ),
                                              autofocus: true,
                                              initialValue: phone.substring(4),
                                              keyboardType: TextInputType.phone,
                                              onChanged: (value) {
                                                phoneNumber = value;
                                                tel = phoneNumber;
                                              },
                                            ),
                                            actions: <Widget>[
                                              FilledButton(
                                                  onPressed: (() {
                                                    if (_formKey.currentState!
                                                        .validate()) {
                                                      Navigator.pop(context);
                                                      continueStep();
                                                    }
                                                  }),
                                                  child:
                                                      const Text('Continuer')),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 15),
                                      child: ListTile(
                                        leading: Container(
                                          height: 50,
                                          width: 50,
                                          decoration: BoxDecoration(
                                            // color: Colors.amber,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            image: const DecorationImage(
                                              image: AssetImage(
                                                  'assets/images/mtn_momo.png'),
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                        trailing: const Icon(
                                          Icons.keyboard_arrow_right_sharp,
                                          color: Colors.grey,
                                          size: 20,
                                        ),
                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Row(
                                              children: [
                                                Text(
                                                  'MTN MoMo',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w900),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.01,
                                            ),
                                            Text(
                                              '2%',
                                              // '2.5% - Frais marchand',
                                              // 'Indisponible',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleSmall,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                                SizedBox(
                                  height: Get.height * 0.01,
                                ),
                              ],
                            ),
                            isActive: currentStep >= 2,
                            state: currentStep >= 2
                                ? StepState.complete
                                : StepState.disabled,
                          ),
                          Step(
                            title: const Text(''),
                            content: Center(
                              child: SingleChildScrollView(
                                child: Center(
                                  child: Column(
                                    children: [
                                      Text(
                                        'Détails de la transaction',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleSmall,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      SizedBox(
                                        width: Get.width,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            //ecole
                                            Card(
                                              elevation: 5,
                                              child: Container(
                                                width: size.width,
                                                margin: const EdgeInsets.only(
                                                  bottom:
                                                      Dimensions.MobileMargin -
                                                          10,
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal:
                                                      Dimensions.MobileMargin,
                                                  vertical:
                                                      Dimensions.MobileMargin -
                                                          10,
                                                ),
                                                decoration: const BoxDecoration(
                                                  // color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(8.0)),
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const AutoSizeText(
                                                      "ELEVE",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                      minFontSize: 12,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.03,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const AutoSizeText(
                                                          "MATRICULE:",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            // color: Colors.grey,
                                                          ),
                                                          minFontSize: 10,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        AutoSizeText(
                                                          matricule.matricule,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          minFontSize: 8,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.015,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const AutoSizeText(
                                                          "NOM:",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            // color: Colors.grey,
                                                          ),
                                                          minFontSize: 10,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        AutoSizeText(
                                                          matricule.nom,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          minFontSize: 8,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.015,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const AutoSizeText(
                                                          "PRÉNOM(S):",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            // color: Colors.grey,
                                                          ),
                                                          minFontSize: 10,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        AutoSizeText(
                                                          matricule.prenom,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          minFontSize: 8,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.015,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const AutoSizeText(
                                                          "DATE DE NAISSANCE:",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            // color: Colors.grey,
                                                          ),
                                                          minFontSize: 10,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        AutoSizeText(
                                                          matricule
                                                              .date_naissance,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          minFontSize: 8,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.015,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const AutoSizeText(
                                                          "LIEU DE NAISSANCE:",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            // color: Colors.grey,
                                                          ),
                                                          minFontSize: 10,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        AutoSizeText(
                                                          matricule
                                                              .lieu_naissance,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          minFontSize: 8,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.015,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const AutoSizeText(
                                                          "CLASSE:",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            // color: Colors.grey,
                                                          ),
                                                          minFontSize: 10,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        AutoSizeText(
                                                          matricule.classe,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                          minFontSize: 8,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        )
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.02,
                                                    ),
                                                    const Divider(
                                                      thickness: 1,
                                                      color: Colors.grey,
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.02,
                                                    ),
                                                    const AutoSizeText(
                                                      "SERVICE",
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        //
                                                      ),
                                                      minFontSize: 12,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.015,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const AutoSizeText(
                                                          "TYPE:",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            // color: Colors.grey,
                                                          ),
                                                          minFontSize: 10,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        AutoSizeText(
                                                          service,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          minFontSize: 8,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.015,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const AutoSizeText(
                                                          "MONTANT INITIAL:",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            // color: Colors.grey,
                                                          ),
                                                          minFontSize: 10,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        AutoSizeText(
                                                          "${_montantController.text} F",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          minFontSize: 8,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.015,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const AutoSizeText(
                                                          "FRAIS TRANSACTION",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                            // color: Colors.grey,
                                                          ),
                                                          minFontSize: 10,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        AutoSizeText(
                                                          '${((_montantController.text.isNotEmpty) ? (double.parse(_montantController.text.replaceAll(' ', '')) * 0.02).round() : 0)} F',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          minFontSize: 8,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                    SizedBox(
                                                      height:
                                                          size.height * 0.015,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        const AutoSizeText(
                                                          "TOTAL A PAYER:",
                                                          style: TextStyle(
                                                            // color: Colors.grey,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .normal,
                                                          ),
                                                          minFontSize: 10,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        AutoSizeText(
                                                          '${((_montantController.text.isNotEmpty) ? (double.parse(_montantController.text.replaceAll(' ', '')) + (double.parse(_montantController.text.replaceAll(' ', '')) * 0.02)).round() : 0)} F',
                                                          textAlign:
                                                              TextAlign.center,
                                                          style:
                                                              const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                          ),
                                                          minFontSize: 8,
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                            // content: Center(
                            //   child: Column(
                            //     mainAxisAlignment: MainAxisAlignment.center,
                            //     crossAxisAlignment: CrossAxisAlignment.center,
                            //     children: [
                            //       const CircleAvatar(
                            //         backgroundImage:
                            //             AssetImage('assets/images/mtn_momo.png'),
                            //         radius: 30,
                            //         backgroundColor: Colors.amber,
                            //       ),
                            //       const SizedBox(
                            //         height: 20,
                            //       ),
                            //       Text(
                            //         "Paiement via MTN CI en cours ...",
                            //         style: Theme.of(this.context).textTheme.titleSmall,
                            //       ),
                            //       const SizedBox(
                            //         height: 20,
                            //       ),
                            //       Text(
                            //         "Nous avons juste besoin de votre confirmation",
                            //         style: Theme.of(this.context).textTheme.bodySmall,
                            //       ),
                            //       SizedBox(
                            //         height: height * 0.17,
                            //       ),
                            //       const CircularProgressIndicator(),
                            //       SizedBox(
                            //         height: height * 0.25,
                            //       ),
                            //       Text(
                            //         "Veuillez composer le *133# pour valider votre\n paiement via MTN Mobile Money",
                            //         style: Theme.of(this.context).textTheme.titleSmall,
                            //         textAlign: TextAlign.center,
                            //       ),
                            //     ],
                            //   ),
                            ,
                            isActive: currentStep >= 3,
                            state: currentStep >= 3
                                ? StepState.complete
                                : StepState.disabled,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ));
  }
}

class _SpaceFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = '';
    int count = 0;
    for (int i = newValue.text.length - 1; i >= 0; i--) {
      count++;
      newText = newValue.text[i] + newText;
      if (count % 3 == 0 && i > 0) {
        newText = ' $newText';
      }
    }
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
      composing: TextRange.empty,
    );
  }
}
