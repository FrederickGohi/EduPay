import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../../api/api.dart';
import '../../constantes/constantes.dart';
import '../../models/cantine.dart';
import 'autre_montant.dart';
import 'mode_paiement.dart';
import 'paiement.dart';

class GetCantine extends StatefulWidget {
  Map data;
  GetCantine({Key? key, required this.data}) : super(key: key);

  @override
  State<GetCantine> createState() => _GetCantineState();
}

class _GetCantineState extends State<GetCantine> {
  TextEditingController _montantController = TextEditingController();
  final formatter = NumberFormat.currency(locale: 'fr_XOF', symbol: 'XOF');

  final _formKey = GlobalKey<FormState>();

  Future<List<Cantine>> getMontant() async {
    List<Cantine> listMontant = [];
    var response = await http.post(
      Uri.parse(Api.getCantine),
      body: {
        // 'id_ecole': '${widget.data['ecole_classe']['l_ecole']['id']}',
        'classe': "${widget.data['classe']}",
      },
    );
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      if (responseBody['success']) {
        for (var element in (responseBody['data'] as List)) {
          listMontant.add(Cantine.fromJson(element));
        }
      }
      inspect(responseBody);
    }
    return listMontant;
  }

  @override
  void initState() {
    super.initState();
    _montantController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: Container(
          height: size.height * 0.055,
          width: size.width * 0.9,
          decoration: BoxDecoration(
            color: Theme.of(context).buttonTheme.colorScheme!.primaryContainer,
            borderRadius: BorderRadius.circular(20.0),
            border: const Border.fromBorderSide(BorderSide.none),
          ),
          child: InkWell(
            onTap: () {
              Get.to(
                () => AutreMontant(data: widget.data),
                fullscreenDialog: true,
              );
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AutoSizeText(
                  "Saisir un montant",
                  style: TextStyle(
                      color:
                          Theme.of(context).buttonTheme.colorScheme!.onPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const AutoSizeText(
          "ECHEANCIER CANTINE",
          // style: GoogleFonts.roboto(
          //     color: Colors.white, fontWeight: FontWeight.bold),
          maxFontSize: 15,
          minFontSize: 14,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
        // backgroundColor: Couleurs.CouleurSecondaire,
      ),
      body: buildAll(),
    );
  }

  Widget buildAll() {
    return FutureBuilder(
      future: getMontant(),
      builder: (context, AsyncSnapshot<List<Cantine>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Shimmer.fromColors(
              //Chargement shimmer
              baseColor: const Color.fromARGB(255, 212, 208, 208),
              highlightColor: const Color.fromARGB(255, 253, 250, 250),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Row(
                      children: [
                        const CircleAvatar(),
                        Container(
                            margin: const EdgeInsets.only(
                              left: 5.0,
                            ),
                            // height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.7,
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 0, 0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Row(
                      children: [
                        const CircleAvatar(),
                        Container(
                            margin: const EdgeInsets.only(
                              left: 5.0,
                            ),
                            // height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.7,
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 0, 0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Row(
                      children: [
                        const CircleAvatar(),
                        Container(
                            margin: const EdgeInsets.only(
                              left: 5.0,
                            ),
                            // height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.7,
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 0, 0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Row(
                      children: [
                        const CircleAvatar(),
                        Container(
                            margin: const EdgeInsets.only(
                              left: 5.0,
                            ),
                            // height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.7,
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 0, 0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Row(
                      children: [
                        const CircleAvatar(),
                        Container(
                            margin: const EdgeInsets.only(
                              left: 5.0,
                            ),
                            // height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.7,
                            padding: const EdgeInsets.all(8),
                            decoration: const BoxDecoration(
                              color: Color.fromARGB(255, 255, 0, 0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                            )),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                  ],
                ),
              ));
        }
        if (snapshot.data == null) {
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.4),
            child: const Center(child: Text('Vide')),
          );
        }
        if (snapshot.data!.isNotEmpty) {
          return Column(
            children: [
              SizedBox(
                // color: Colors.amber,
                height: MediaQuery.of(context).size.height * 0.8,
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    Cantine cantine = snapshot.data![index];
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).padding.bottom),
                            child: ListTile(
                              leading: const CircleAvatar(
                                radius: 35,
                                child: Icon(Icons.school, color: Colors.white),
                              ),
                              trailing: const Icon(
                                Icons.keyboard_arrow_right_sharp,
                                size: 20,
                              ),
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cantine.libelle,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w900),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${cantine.montant}' ' CFA',
                                  )
                                ],
                              ),
                              onTap: (() {
                                var data = widget.data;
                                Get.to(() => ModePaiement(
                                      data: data,
                                      montant: cantine.montant,
                                      echeancier: cantine.libelle,
                                    ));
                              }),
                            ),
                          ),
                          const Divider(),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 50,),
            ],
          );
        } else {
          return Padding(
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.height * 0.4),
            child: const Center(child: Text('Vide')),
          );
        }
      },
    );
  }
}
