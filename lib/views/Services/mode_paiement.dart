import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../widgets/toast_alert.dart';
import 'paiement.dart';

class ModePaiement extends StatefulWidget {
  Map data;
  final montant;
  final String echeancier;

  ModePaiement(
      {Key? key,
      required this.data,
      required this.montant,
      required this.echeancier})
      : super(key: key);

  @override
  State<ModePaiement> createState() => _ModePaiementState();
}

class _ModePaiementState extends State<ModePaiement> {
  final TextEditingController _telephoneController = TextEditingController();

  void maintenance() {
    AlertWidget.notificationToast(
      "Bientôt disponbile",
      Colors.deepOrange,
      Colors.white,
      1,
      context,
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    NumberFormat myFormat = NumberFormat.decimalPattern('eu');
    Size size = MediaQuery.of(context).size;
    var v1 = widget.montant.toString();

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
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Choix de l'opérateur"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              elevation: 8,
              child: InkWell(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      });
                  Future.delayed(const Duration(milliseconds: 1500), () {
                    Navigator.of(context).pop();

                    var data = widget.data;

                    Get.to(() => PaiementPage(
                          data: data,
                          mode: 'WAVECI',
                          montant: v2,
                          frais: fraisWave,
                          frais_eliah: 'FRAIS ELIAH.CI',
                          eliah: fraisEliah,
                          tel: _telephoneController.text.toString(),
                          echeancier: widget.echeancier.toString(),
                        ));

                    // paywave();
                  });
                },
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
                          image: AssetImage('assets/images/wave.png'),
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
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                          // '${v2 + fraisWave} F CFA',
                          '2.5% - ${myFormat.format(wave)} FCFA',
                          // '2.5% - Frais marchand',

                          style: Theme.of(context).textTheme.titleSmall,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              elevation: 8,
              child: InkWell(
                onTap: () {
                  // maintenance();
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Saisir le numéro de tél.'),
                          content: Form(
                            key: formKey,
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: _telephoneController,
                              decoration: const InputDecoration(
                                  hintText: "Ex. 0506030405"),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Numéro de tél. requis';
                                }

                                // Vérifier si le numéro commence par "05" et contient 10 chiffres.
                                if (!value.startsWith('05') ||
                                    value.replaceAll(' ', '').length != 10) {
                                  return 'Numéro de tél. invalide';
                                }
                                return null;
                              },
                            ),
                          ),
                          actions: <Widget>[
                            OutlinedButton(
                              child: const Text("Annuler"),
                              onPressed: () => Navigator.pop(context),
                            ),
                            ElevatedButton(
                                onPressed: (() {
                                  if (formKey.currentState!.validate()) {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        });
                                    // Get.to(() => ProfilPage());
                                    Future.delayed(
                                        const Duration(milliseconds: 1500), () {
                                      Navigator.of(context).pop();

                                      var data = widget.data;

                                      Get.to(() => PaiementPage(
                                            // schoolid: widget.schoolid,
                                            data: data,
                                            mode: 'MTNCI',
                                            frais: fraisMTN,
                                            frais_eliah: 'FRAIS ELIAH.CI',
                                            eliah: fraisEliah,
                                            montant: v2,
                                            tel: _telephoneController.text
                                                .toString(),
                                            echeancier:
                                                widget.echeancier.toString(),
                                          ));

                                      // paymtn();
                                    });
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
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/mtn.png'),
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
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        // Text(
                        //   "Indisponible",
                        //   style: Theme.of(context).textTheme.titleMedium,
                        // )
                        Text(
                          '2.5% - ${myFormat.format(mtn)} FCFA',
                          // '2.5% - Frais marchand',
                          // 'Indisponible',
                          style: Theme.of(context).textTheme.titleSmall,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              elevation: 8,
              child: InkWell(
                onTap: () {
                  // maintenance();
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      });
                  Future.delayed(const Duration(milliseconds: 1500), () {
                    Navigator.of(context).pop();

                    var data = widget.data;
                    // maintenance();
                    Get.to(() => PaiementPage(
                          data: data,
                          mode: 'CARD',
                          frais: fraisVISA,
                          eliah: fraisEliah,
                          frais_eliah: 'FRAIS ELIAH.CI',
                          montant: v2,
                          tel: _telephoneController.text.toString(),
                          echeancier: widget.echeancier.toString(),
                        ));
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/visa.png'),
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
                              'VISA / MASTERCARD',
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        // const Text("Indisponible")
                        // SizedBox(
                        //   height: MediaQuery.of(context).size.height * 0.01,
                        // ),
                        Text(
                          '3.5% - ${myFormat.format(visa)} FCFA',
                          style: Theme.of(context).textTheme.titleSmall,
                          // '3.5% - Frais marchand',
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: Get.height * 0.01,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Card(
              elevation: 8,
              child: InkWell(
                onTap: () {
                  maintenance();
                  // showDialog(
                  //     context: context,
                  //     builder: (context) {
                  //       return const Center(
                  //         child: CircularProgressIndicator(),
                  //       );
                  //     });
                  // Future.delayed(const Duration(milliseconds: 1500), () {
                  //   Navigator.of(context).pop();

                  // var data = widget.data;
                  // // maintenance();
                  // Get.to(() => PaiementPage(
                  //       data: data,
                  //       mode: 'Orange Money',
                  //       frais: fraisOrange,
                  //       eliah: fraisEliah,
                  //       frais_eliah: 'FRAIS ORANGE.CI',
                  //       montant: v2,
                  //       tel: _telephoneController.text.toString(),
                  //       echeancier: widget.echeancier.toString(),
                  //     ));

                  // paywave();
                  // });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: ListTile(
                    leading: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: const DecorationImage(
                          image: AssetImage('assets/images/orange.png'),
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
                              style: TextStyle(fontWeight: FontWeight.w900),
                            ),
                            // Text(
                            //   '3%',
                            //   style: TextStyle(
                            //       fontWeight: FontWeight.bold,
                            //       // fontSize: 14,
                            //       color: Colors.grey),
                            // ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.01,
                        ),
                        Text(
                          "Indisponible",
                          style: Theme.of(context).textTheme.titleSmall,
                        )
                        // SizedBox(
                        //   height: MediaQuery.of(context).size.height * 0.01,
                        // ),
                        // Text(
                        //   myFormat.format(orange) + ' FCFA',
                        //   // '2.000 F - Frais marchand',
                        //   // 'Indisponible',
                        //   style: const TextStyle(
                        //       color: Color.fromRGBO(0, 96, 164, 0.925),
                        //       // fontSize: 18,
                        //       fontWeight: FontWeight.bold),
                        // )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
