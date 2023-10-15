import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../widgets/root.dart';
import 'Services/paiement.dart';

class PaymentProcessing extends StatefulWidget {
  const PaymentProcessing({super.key});

  @override
  State<PaymentProcessing> createState() => _PaymentProcessingState();
}

class _PaymentProcessingState extends State<PaymentProcessing> {
  int currentStep = 0;
  final TextEditingController _montantController = TextEditingController();
  final TextEditingController _telephoneController = TextEditingController();

  final formatter = NumberFormat.currency(locale: 'fr_XOF', symbol: 'XOF');

  final _formKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();

  bool isMontantValid = false;
  String montantError = '';

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

  Widget controlBuilders(context, details) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
          ? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  continueStep();
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
                    Theme.of(context).buttonTheme.colorScheme!.primaryContainer,
                  ), //verifier si la couleur est nul (si oui alors on lui donne la couleur pas defaut)
                ),
                child: Text(
                  'Continuer',
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).buttonTheme.colorScheme!.onPrimary,
                  ),
                ),
              ),
            )
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
                        Size(MediaQuery.of(context).size.width, 55),
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
                      'Continuer',
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
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: TextButton(
                            onPressed: () {
                              Get.offAll(() => const Root());
                            },
                            child: const Text(
                              'Annuler la transaction',
                              // Texte pour l'étape 3
                            ),
                          ),
                        )
                      : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: const Text('EduPay'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.85,
              // color: Colors.amber,
              child: Stepper(
                elevation: 0,
                controlsBuilder: controlBuilders,
                type: StepperType.horizontal, // Changez le type en horizontal
                onStepTapped: onStepTapped,
                onStepContinue: continueStep,
                onStepCancel: cancelStep,
                currentStep: currentStep,
                steps: [
                  Step(
                    title: const Text(''),
                    // subtitle: Text('data'),
                    content: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child: Text(
                          'Identité',
                          textAlign: TextAlign.center,
                        )),
                        Card(
                          elevation: 5.0,
                          margin: EdgeInsets.all(16.0),
                          child: Padding(
                            padding: EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ListTile(
                                  leading: Icon(Icons.person),
                                  title: Text('Nom: John'),
                                ),
                                ListTile(
                                  leading: Icon(Icons.person),
                                  title: Text('Prénom: Doe'),
                                ),
                                ListTile(
                                  leading: Icon(Icons.school),
                                  title: Text('Classe: 5A'),
                                ),
                                ListTile(
                                  leading: Icon(Icons.school),
                                  title: Text('École: École XYZ'),
                                ),
                                // Ajoutez d'autres informations du profil de l'élève ici
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
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
                            'Saisissez le montant'.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.titleSmall,
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
                                hintStyle: const TextStyle(fontSize: 30),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
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
                              // maintenance();
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text(
                                          'Saisir le numéro de tél.'),
                                      content: Form(
                                        key: formKey,
                                        child: TextFormField(
                                          keyboardType: TextInputType.phone,
                                          controller: _telephoneController,
                                          decoration: const InputDecoration(
                                              hintText: "Ex. 0506030405"),
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Numéro de tél. requis';
                                            }

                                            // Vérifier si le numéro commence par "05" et contient 10 chiffres.
                                            if (!value.startsWith('05') ||
                                                value
                                                        .replaceAll(' ', '')
                                                        .length !=
                                                    10) {
                                              return 'Numéro de tél. invalide';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      actions: <Widget>[
                                        OutlinedButton(
                                          child: const Text("Annuler"),
                                          onPressed: () =>
                                              Navigator.pop(context),
                                        ),
                                        FilledButton(
                                            onPressed: (() {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                Navigator.pop(context);
                                                continueStep();
                                              }
                                            }),
                                            child: const Text('Continuer')),
                                      ],
                                    );
                                  });
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: ListTile(
                                leading: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.amber,
                                    borderRadius: BorderRadius.circular(20),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        Text(
                                          'MTN MoMo',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
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
                        Card(
                          elevation: 8,
                          child: InkWell(
                            onTap: () {},
                            // -----------------------------------------------------------------------
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: ListTile(
                                leading: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: Colors.white,
                                    image: const DecorationImage(
                                      image:
                                          AssetImage('assets/images/wave.png'),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.keyboard_arrow_right_sharp,
                                  // color: Colors.grey,
                                  size: 20,
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        Text(
                                          'Wave',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                    ),
                                    Text(
                                      '2%',
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
                        Card(
                          elevation: 8,
                          child: InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: ListTile(
                                leading: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/orange.png'),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        Text(
                                          'Orange Money',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                    ),
                                    Text(
                                      '2%',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                      // '3.5% - Frais marchand',
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
                        Card(
                          elevation: 8,
                          child: InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: ListTile(
                                leading: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    // color: Colors.white,
                                    borderRadius: BorderRadius.circular(20),
                                    image: const DecorationImage(
                                      image: AssetImage(
                                          'assets/images/moov_money.png'),
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        Text(
                                          'Moov Money',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                    ),
                                    Text(
                                      '2%',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                      // '3.5% - Frais marchand',
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
                        Card(
                          elevation: 8,
                          child: InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: ListTile(
                                leading: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  child: Container(
                                    // height: size.height * 0.1,
                                    // width: size.width * 0.2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: Colors.white,
                                      image: const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/visa_mastercard.png'),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ),
                                ),
                                trailing: const Icon(
                                  Icons.keyboard_arrow_right_sharp,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Row(
                                      children: [
                                        Text(
                                          'VISA / MASTERCARD',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.01,
                                    ),
                                    // const Text("Indisponible")
                                    // SizedBox(
                                    //   height: MediaQuery.of(context).size.height * 0.01,
                                    // ),
                                    Text(
                                      '2%',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleSmall,
                                      // '3.5% - Frais marchand',
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
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
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/mtn_momo.png'),
                            radius: 30,
                            backgroundColor: Colors.amber,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Paiement via MTN CI en cours ...",
                            style: Theme.of(this.context).textTheme.titleSmall,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Nous avons juste besoin de votre confirmation",
                            style: Theme.of(this.context).textTheme.bodySmall,
                          ),
                          SizedBox(
                            height: height * 0.17,
                          ),
                          const CircularProgressIndicator(),
                          SizedBox(
                            height: height * 0.25,
                          ),
                          Text(
                            "Veuillez composer le *133# pour valider votre\n paiement via MTN Mobile Money",
                            style: Theme.of(this.context).textTheme.titleSmall,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                    isActive: currentStep >= 3,
                    state: currentStep >= 3
                        ? StepState.complete
                        : StepState.disabled,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
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
