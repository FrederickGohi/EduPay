import 'dart:convert';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../../api/api.dart';
import '../../models/scolarite.dart';
import 'autre_montant.dart';
import 'mode_paiement.dart';

class GetScolarite extends StatefulWidget {
  Map data;
  GetScolarite({Key? key, required this.data}) : super(key: key);

  @override
  State<GetScolarite> createState() => _GetScolariteState();
}

class _GetScolariteState extends State<GetScolarite> {
  final formatter = NumberFormat.currency(locale: 'fr_XOF', symbol: 'XOF');

  Future<List<Scolarite>> getMontant() async {
    List<Scolarite> listMontant = [];
    var response = await http.post(
      Uri.parse(Api.getScolarite),
      body: {
        'classe': "${widget.data['classe']}",
      },
    );
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      if (responseBody['success']) {
        for (var element in (responseBody['data'] as List)) {
          listMontant.add(Scolarite.fromJson(element));
        }
      }
    }
    return listMontant;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        floatingActionButton: Container(
            height: size.height * 0.055,
            width: size.width * 0.9,
            decoration: BoxDecoration(
              color:
                  Theme.of(context).buttonTheme.colorScheme!.primaryContainer,
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
                        color: Theme.of(context)
                            .buttonTheme
                            .colorScheme!
                            .onPrimary,
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
            "ECHEANCIER SCOLARITE",
            maxFontSize: 15,
            minFontSize: 14,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          centerTitle: true,
        ),
        body: buildAll());
  }

  Widget buildAll() {
    return FutureBuilder(
      future: getMontant(),
      builder: (context, AsyncSnapshot<List<Scolarite>> snapshot) {
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
          return const Center(
            child: Text('Vide'),
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
                    Scolarite scolarite = snapshot.data![index];
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: MediaQuery.of(context).padding.bottom,
                              // vertical: 15
                            ),
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
                                    scolarite.libelle,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w900),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    '${scolarite.montant} FCFA',
                                  )
                                ],
                              ),
                              onTap: (() {
                                var data = widget.data;
                                Get.to(
                                  () => ModePaiement(
                                      data: data,
                                      montant: scolarite.montant,
                                      echeancier: scolarite.libelle),
                                );
                              }),
                            ),
                          ),
                          const Divider(
                            color: Colors.grey,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 50,
              ),
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
