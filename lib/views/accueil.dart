import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:edupay/views/payment_processing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../api/api.dart';
import '../modelss/matricule.dart';
import '../widgets/custom_card_widget.dart';
import '../widgets/info_message.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key, this.schoolid});
  final String? schoolid;

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  final TextEditingController _naissanceController = TextEditingController();
  final TextEditingController _matriculeController = TextEditingController();
  bool isDate = false;

  final _formKey = GlobalKey<FormState>();

  Future<List<Matricule>> getStudent(
      var matricule, var idecole, var ecole) async {
    List<Matricule> listMatricule = [];
    var response = await http.post(
      Uri.parse(Api.checkMatricule),
      body: {
        'matricule': matricule.toString(),
        'id_ecole': idecole.toString(),
      },
    );
    print(matricule);
    if (response.statusCode == 200) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pop();
      Get.back();
      var responseBody = jsonDecode(response.body);
      if (responseBody['success']) {
        for (var element in (responseBody['data'] as List)) {
          listMatricule.add(Matricule.fromJson(element));
        }
        Get.to(() => PaymentProcessing(
            matricules: listMatricule, ecole: ecole, idecole: idecole));
      } else {
        InfoMessage.snackbar(
            Get.context!, 'Matricule non identifié, veuillez rééssayer');
      }
    }
    return listMatricule;
  }

  // void valider({required TextEditingController matricule}) async {
  //   Get.to(() => const PaymentProcessing(matricules:null));
  // }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: const AutoSizeText(
          "EduPay",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        // backgroundColor: Couleurs.CouleurSecondaire,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              // size: 35,
            ),
            onPressed: () {
              // logout();
            },
          ),
        ],
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.menu)),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: size.height * 1,
          child: Column(
            children: [
              const SizedBox(
                height: 25,
              ),
              Text(
                "Choisissez votre l'école",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent:
                          MediaQuery.of(context).size.width * 0.65,
                      // childAspectRatio: 0.57,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 7),
                  children: [
                    CustomCardWidget(
                      imageAssetPath: 'assets/images/ufhb.png',
                      title: "Université\n FHB",
                      onTap: () {
                        showAdaptiveDialog(
                          context: context,
                          builder: (BuildContext context) {
                            TextEditingController matriculeController =
                                TextEditingController(); // Contrôleur pour le champ de saisie du matricule

                            return StatefulBuilder(
                              builder: (context, setState) {
                                return AlertDialog(
                                  title: Text(
                                    'Saisissez le matricule',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: matriculeController,
                                        decoration: const InputDecoration(
                                          labelText: 'Matricule',
                                          hintText: 'Ex : 848455J',
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Annuler"),
                                    ),
                                    FilledButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              });

                                          String matricule =
                                              matriculeController.text;
                                          var idecole = 1;
                                          var ecole = "Université FHB";

                                          Future.delayed(
                                              const Duration(
                                                  milliseconds: 1500), () {
                                            // Navigator.of(context).pop();

                                            getStudent(
                                                matricule, idecole, ecole);
                                          });
                                        },
                                        child: const Text('Rechercher')),
                                  ],
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                    CustomCardWidget(
                      imageAssetPath: 'assets/images/unabg.png',
                      title: "Université\n Nangui Abrogoua",
                      onTap: () {
                        showAdaptiveDialog(
                          context: context,
                          builder: (BuildContext context) {
                            TextEditingController matriculeController =
                                TextEditingController(); // Contrôleur pour le champ de saisie du matricule

                            return StatefulBuilder(
                              builder: (context, setState) {
                                return AlertDialog(
                                  title: Text(
                                    'Saisissez le matricule',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: matriculeController,
                                        decoration: const InputDecoration(
                                          labelText: 'Matricule',
                                          hintText: 'Ex : 848455J',
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Annuler"),
                                    ),
                                    FilledButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              });

                                          String matricule =
                                              matriculeController.text;
                                          var idecole = 2;
                                          var ecole =
                                              "Université Nangui Abrogoua";

                                          Future.delayed(
                                              const Duration(
                                                  milliseconds: 1500), () {
                                            // Navigator.of(context).pop();

                                            getStudent(
                                                matricule, idecole, ecole);
                                          });
                                        },
                                        child: const Text('Rechercher')),
                                  ],
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                    CustomCardWidget(
                      imageAssetPath: 'assets/images/inp.png',
                      title: "INPHB",
                      onTap: () {
                        showAdaptiveDialog(
                          context: context,
                          builder: (BuildContext context) {
                            TextEditingController matriculeController =
                                TextEditingController(); // Contrôleur pour le champ de saisie du matricule

                            return StatefulBuilder(
                              builder: (context, setState) {
                                return AlertDialog(
                                  title: Text(
                                    'Saisissez le matricule',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: matriculeController,
                                        decoration: const InputDecoration(
                                          labelText: 'Matricule',
                                          hintText: 'Ex : 848455J',
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Annuler"),
                                    ),
                                    FilledButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              });

                                          String matricule =
                                              matriculeController.text;
                                          var idecole = 3;
                                          var ecole = "INPHB";

                                          Future.delayed(
                                              const Duration(
                                                  milliseconds: 1500), () {
                                            // Navigator.of(context).pop();

                                            getStudent(
                                                matricule, idecole, ecole);
                                          });
                                        },
                                        child: const Text('Rechercher')),
                                  ],
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                    CustomCardWidget(
                      imageAssetPath: 'assets/images/esatic.png',
                      title: "ESATIC",
                      onTap: () {
                        showAdaptiveDialog(
                          context: context,
                          builder: (BuildContext context) {
                            TextEditingController matriculeController =
                                TextEditingController(); // Contrôleur pour le champ de saisie du matricule

                            return StatefulBuilder(
                              builder: (context, setState) {
                                return AlertDialog(
                                  title: Text(
                                    'Saisissez le matricule',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: matriculeController,
                                        decoration: const InputDecoration(
                                          labelText: 'Matricule',
                                          hintText: 'Ex : 848455J',
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Annuler"),
                                    ),
                                    FilledButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              });

                                          String matricule =
                                              matriculeController.text;
                                          var idecole = 4;
                                          var ecole = "ESATIC";

                                          Future.delayed(
                                              const Duration(
                                                  milliseconds: 1500), () {
                                            // Navigator.of(context).pop();

                                            getStudent(
                                                matricule, idecole, ecole);
                                          });
                                        },
                                        child: const Text('Rechercher')),
                                  ],
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                    CustomCardWidget(
                      imageAssetPath: 'assets/images/classic.png',
                      title: "Lycée Classique Abidjan",
                      onTap: () {
                        showAdaptiveDialog(
                          context: context,
                          builder: (BuildContext context) {
                            TextEditingController matriculeController =
                                TextEditingController(); // Contrôleur pour le champ de saisie du matricule

                            return StatefulBuilder(
                              builder: (context, setState) {
                                return AlertDialog(
                                  title: Text(
                                    'Saisissez le matricule',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: matriculeController,
                                        decoration: const InputDecoration(
                                          labelText: 'Matricule',
                                          hintText: 'Ex : 848455J',
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Annuler"),
                                    ),
                                    FilledButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              });

                                          String matricule =
                                              matriculeController.text;
                                          var idecole = 5;
                                          var ecole = "Lycée Classique Abidjan";

                                          Future.delayed(
                                              const Duration(
                                                  milliseconds: 1500), () {
                                            // Navigator.of(context).pop();

                                            getStudent(
                                                matricule, idecole, ecole);
                                          });
                                        },
                                        child: const Text('Rechercher')),
                                  ],
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                    CustomCardWidget(
                      imageAssetPath: 'assets/images/viateur.png',
                      title: "Collège Saint Viateur",
                      onTap: () {
                        showAdaptiveDialog(
                          context: context,
                          builder: (BuildContext context) {
                            TextEditingController matriculeController =
                                TextEditingController(); // Contrôleur pour le champ de saisie du matricule

                            return StatefulBuilder(
                              builder: (context, setState) {
                                return AlertDialog(
                                  title: Text(
                                    'Saisissez le matricule',
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: matriculeController,
                                        decoration: const InputDecoration(
                                          labelText: 'Matricule',
                                          hintText: 'Ex : 848455J',
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text("Annuler"),
                                    ),
                                    FilledButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              });

                                          String matricule =
                                              matriculeController.text;
                                          var idecole = 6;
                                          var ecole = "Collège Saint Viateur";

                                          Future.delayed(
                                              const Duration(
                                                  milliseconds: 1500), () {
                                            // Navigator.of(context).pop();

                                            getStudent(
                                                matricule, idecole, ecole);
                                          });
                                        },
                                        child: const Text('Rechercher')),
                                  ],
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
