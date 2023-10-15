import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constantes/constantes.dart';
import 'mode_paiement.dart';

class AutreMontant extends StatefulWidget {
  Map data;
   AutreMontant({Key? key, required this.data}) : super(key: key);

  @override
  State<AutreMontant> createState() => _AutreMontantState();
}

class _AutreMontantState extends State<AutreMontant> {
  final TextEditingController _montantController = TextEditingController();
  final formatter = NumberFormat.currency(locale: 'fr_XOF', symbol: 'XOF');

  final _formKey = GlobalKey<FormState>();
  late FocusNode _montantFocusNode = FocusNode();

  bool isMontantValid = false;
  String montantError = '';

  @override
  void initState() {
    super.initState();
    _montantFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _montantFocusNode.dispose();
    super.dispose();
  }

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
      } else if (montant <= 999) {
        montantError = 'Le montant minimum est de 1000 F';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        height: MediaQuery.of(context).size.height * 0.055,
        width: MediaQuery.of(context).size.width * 0.92,
        decoration: BoxDecoration(
          color: isMontantValid
              ? Theme.of(context).buttonTheme.colorScheme!.primaryContainer
              : Colors.grey.shade300, // Gris si le montant n'est pas valide
          borderRadius: BorderRadius.circular(20.0),
          border: const Border.fromBorderSide(BorderSide.none),
        ),
        child: InkWell(
          onTap: isMontantValid
              ? () {
                  // var data = widget.data;

                  if (_formKey.currentState!.validate()) {
                    var v = _montantController.text.toString();
                    var v2 = v.replaceAll(RegExp(r"\s+"), "");
                    var montant = int.parse(v2);

                    FocusScope.of(context).unfocus();

                    Get.to(() => ModePaiement(
                          data: widget.data,
                          montant: montant,
                          echeancier: 'AUTRE MONTANT',
                        ));
                  }
                }
              : null, // null si le montant n'est pas valide
          child: const Center(
            child: AutoSizeText(
              "CONTINUER",
              style: TextStyle(
                  fontSize: 14.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      appBar: AppBar(
        title: const AutoSizeText(
          "SCOLARITE",
          maxFontSize: 15,
          minFontSize: 14,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                  child: AutoSizeText(
                    "Veuillez saisir le montant \n \n que vous voulez payer"
                        .toUpperCase(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Form(
                  key: _formKey,
                  child: ListTile(
                    title: TextFormField(
                      autofocus: true,
                      focusNode: _montantFocusNode,
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
                          suffixText: 'F CFA'),
                      validator: (value) {
                        return value == null || value.isEmpty ? montantError : null;
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
              ),
            ],
          ),
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
