import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../constantes/constantes.dart';
import '../../models/paiements_details.dart';
import '../operations.dart';

class DetailsTransaction extends StatefulWidget {
  final PaiementDetails? paiementDetails;
  final enfant;
  const DetailsTransaction({Key? key, this.enfant, this.paiementDetails})
      : super(key: key);

  @override
  State<DetailsTransaction> createState() => _DetailsTransactionState();
}

class _DetailsTransactionState extends State<DetailsTransaction> {
  getFormatedDate(_date) {
    var inputFormat = DateFormat('dd-MM-yyyy');
    var inputDate = inputFormat.parse(_date);
    var outputFormat = DateFormat('yyyy-MM-dd');
    return outputFormat.format(inputDate);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    var t = int.parse(
        widget.paiementDetails!.montant.replaceAll(RegExp(r"\s+"), ""));
    var total = widget.paiementDetails!.montantInitial +
        widget.paiementDetails!.fraisOperateur +
        widget.paiementDetails!.fraisEliah;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        // backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: () {
          Get.to(() => Operation(
              matricule: widget.paiementDetails!.matricule,
              naissance: widget.paiementDetails!.dateNaissance));
        },
        label: const Text(
          'Nouveau Paiement',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Détails de la transaction"),
        // backgroundColor: Couleurs.CouleurSecondaire,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(
            left: Dimensions.MobileMargin - 10,
            right: Dimensions.MobileMargin - 10,
          ),
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Card(
                elevation: 5,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.only(
                    bottom: Dimensions.MobileMargin - 10,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: Dimensions.MobileMargin,
                    vertical: Dimensions.MobileMargin - 10,
                  ),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    // border: Border.all(
                    //   color: Color.fromARGB(255, 129, 123, 123),
                    //   width: 2,
                    // ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const AutoSizeText(
                        "ELEVE",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        minFontSize: 12,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const AutoSizeText(
                            "NOM & PRENOM(S):",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                            minFontSize: 10,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          AutoSizeText(
                            "${widget.paiementDetails!.nomEleve} ${widget.paiementDetails!.prenomEleve}",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            minFontSize: 8,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const AutoSizeText(
                            "DATE DE NAISSANCE:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                            minFontSize: 10,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          AutoSizeText(
                            widget.paiementDetails!.dateNaissance,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            minFontSize: 8,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const AutoSizeText(
                            "LIEU DE NAISSANCE:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                            minFontSize: 10,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          AutoSizeText(
                            widget.paiementDetails!.lieuNaissance,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            minFontSize: 8,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const AutoSizeText(
                            "CLASSE:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                            minFontSize: 10,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          AutoSizeText(
                            widget.paiementDetails!.classe,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            minFontSize: 8,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const AutoSizeText(
                        "PARENT",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        minFontSize: 12,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const AutoSizeText(
                            "NOM & PRENOM(S):",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                            minFontSize: 10,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          AutoSizeText(
                            widget.paiementDetails!.nomParent,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            minFontSize: 8,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const AutoSizeText(
                            "EMAIL:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                            minFontSize: 10,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          AutoSizeText(
                            widget.paiementDetails!.email,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            minFontSize: 8,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const AutoSizeText(
                        "SERVICE",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        minFontSize: 12,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const AutoSizeText(
                            "TYPE:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                            minFontSize: 10,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          AutoSizeText(
                            widget.paiementDetails!.type.toUpperCase(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            minFontSize: 8,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const AutoSizeText(
                            "MONTANT INITIAL:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                            minFontSize: 10,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          AutoSizeText(
                            "${widget.paiementDetails!.montantInitial} F",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            minFontSize: 8,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const AutoSizeText(
                            "FRAIS TRANSACTION",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                            minFontSize: 10,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          AutoSizeText(
                            // '${totalfrais}',
                            // '$totalfrais F',
                            '${widget.paiementDetails!.fraisOperateur + widget.paiementDetails!.fraisEliah} F',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            minFontSize: 8,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const AutoSizeText(
                            "TOTAL PAYE:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                            minFontSize: 10,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          AutoSizeText(
                            "$total F",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            minFontSize: 8,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const AutoSizeText(
                            "DATE TRANSACTION:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                            minFontSize: 10,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          AutoSizeText(
                            widget.paiementDetails!.dateTransaction,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            minFontSize: 8,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.015,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const AutoSizeText(
                            "REFERENCE:",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.normal,
                            ),
                            minFontSize: 10,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          AutoSizeText(
                            widget.paiementDetails!.reference,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            minFontSize: 8,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                // top: 40,
                bottom: size.height * 0.01,
                right: size.width * 0.2,
                child: Transform.rotate(
                  angle: -30 * 0.0174533,
                  child: Opacity(
                    opacity: 0.6,
                    child: Image(
                      // color: Colors.blueGrey,
                      image: const AssetImage("assets/images/paid.png"),
                      width: size.width * 0.5,
                      height: size.height * 0.5,
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
