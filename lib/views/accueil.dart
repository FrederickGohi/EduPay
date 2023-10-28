import 'package:auto_size_text/auto_size_text.dart';
import 'package:edupay/views/payment_processing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../constantes/constantes.dart';
import '../widgets/custom_card_widget.dart';
import 'operations.dart';

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

  void updateDate(DateTime newDate) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    final String dateFormatted = formatter.format(newDate);
    setState(() {
      _naissanceController.text = dateFormatted;
    });
  }

  Future<void> setBirthday() async {
    DateTime currentDate = DateTime.now();

    FocusScope.of(context).requestFocus(FocusNode());

    DateTime? selectedDate = await showCupertinoModalPopup<DateTime>(
      context: context,
      builder: (BuildContext builder) {
        return Container(
          color: Theme.of(context).canvasColor,
          height: MediaQuery.of(context).size.height / 3,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            dateOrder: DatePickerDateOrder.dmy,
            initialDateTime: currentDate,
            minimumDate: DateTime(1900),
            maximumDate: currentDate,
            onDateTimeChanged: (DateTime newDateTime) {
              updateDate(newDateTime);
            },
          ),
        );
      },
    );

    if (selectedDate != null) {
      updateDate(selectedDate);
    }
  }

  // void setBirthday() async {
  //   DateTime? date = DateTime(1900);
  //   FocusScope.of(context).requestFocus(
  //     FocusNode(),
  //   );
  //   date = await showDatePicker(
  //     initialEntryMode: DatePickerEntryMode.calendarOnly,
  //     context: context,
  //     initialDate: DateTime.now(),
  //     firstDate: DateTime(1900),
  //     lastDate: DateTime.now(),
  //     helpText: "ENTREZ UNE DATE",
  //     errorFormatText: "Format invalide essayez avec: xx/xx/xxxx",
  //     errorInvalidText: "",
  //     fieldHintText: "xx/xx/xxxx",
  //     fieldLabelText: "Entrez la date de naissance",
  //   );
  //   if (date != null) {
  //     final DateFormat formatter = DateFormat('dd-MM-yyyy');
  //     final String dateFormatted = formatter.format(date);
  //     setState(() {
  //       _naissanceController.text = dateFormatted;
  //       isDate = true;
  //     });
  //   }
  // }

  void valider({required TextEditingController matricule}) async {
    Get.to(() => Operation(
          matricule: _matriculeController.text.trim().toString(),
          naissance: _naissanceController.text,
        ));
  }

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
                                          String matricule =
                                              matriculeController.text;
                                          Get.to(
                                              () => const PaymentProcessing());
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
                                          String matricule =
                                              matriculeController.text;
                                          // Faites quelque chose avec le matricule, par exemple, enregistrez-le ou effectuez une action
                                          Get.to(
                                              () => const PaymentProcessing());
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
                                          String matricule =
                                              matriculeController.text;
                                          // Faites quelque chose avec le matricule, par exemple, enregistrez-le ou effectuez une action
                                          Get.to(
                                              () => const PaymentProcessing());
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
                                          String matricule =
                                              matriculeController.text;
                                          // Faites quelque chose avec le matricule, par exemple, enregistrez-le ou effectuez une action
                                          Get.to(
                                              () => const PaymentProcessing());
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
                                          String matricule =
                                              matriculeController.text;
                                          // Faites quelque chose avec le matricule, par exemple, enregistrez-le ou effectuez une action
                                          Get.to(
                                              () => const PaymentProcessing());
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
                                          String matricule =
                                              matriculeController.text;
                                          // Faites quelque chose avec le matricule, par exemple, enregistrez-le ou effectuez une action
                                          Get.to(
                                              () => const PaymentProcessing());
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
