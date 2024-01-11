import 'dart:convert';
import 'dart:developer';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../api/api.dart';
import '../../controllers/c_user.dart';
import '../../modelss/paiements.dart';
import 'package:http/http.dart' as http;
import 'transactions.dart';
import 'package:shimmer/shimmer.dart';

class Historique extends StatefulWidget {
  const Historique({super.key});

  @override
  State<Historique> createState() => _HistoriqueState();
}

class _HistoriqueState extends State<Historique> {
  final _cUser = Get.put(CUser());

  Future<List<Paiement>> getPaiement() async {
    List<Paiement> listPaiement = [];
    var idUser = _cUser.user.id_user.toString();
    var response = await http.post(
      Uri.parse(Api.getEnfant),
      body: {
        'id_user': json.encode(idUser),
      },
    );
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      inspect(responseBody);
      if (responseBody['success']) {
        for (var element in (responseBody['data'] as List)) {
          listPaiement.add(Paiement.fromJson(element));
        }
      }
    }
    return listPaiement;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: CUser(),
        builder: (context) {
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            appBar: AppBar(
              automaticallyImplyLeading: false,
              
              title: const AutoSizeText(
                'Transactions effectuées',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Text('${_cUser.user.nom} ${_cUser.user.prenom}'),
                  // SizedBox(height: 24),
                  buildAll(),
                ],
              ),
            ),
          );
        });
  }

  Widget buildAll() {
    return FutureBuilder(
      future: getPaiement(),
      builder: (context, AsyncSnapshot<List<Paiement>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Shimmer.fromColors(
              //Chargement shimmer
              baseColor: const Color.fromARGB(255, 238, 236, 236),
              highlightColor: Theme.of(context).scaffoldBackgroundColor,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
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
                    const SizedBox(
                      height: 20,
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
                    const SizedBox(
                      height: 20,
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
                    const SizedBox(
                      height: 20,
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
                    const SizedBox(
                      height: 20,
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
                    const SizedBox(
                      height: 20,
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
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ));
        }
        if (snapshot.data == null) {
          return const Center(child: Text('Echec de la connexion'));
        }
        if (snapshot.data!.isNotEmpty) {
          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  // color: Colors.amber,
                  height: MediaQuery.of(context).size.height,
                  child: ListView.builder(
                    // scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Paiement paiement = snapshot.data![index];
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: const CircleAvatar(
                                    child: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                )),
                                title: Text(
                                  paiement.prenom_eleve,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w900),
                                ),
                                onTap: () {
                                  Get.to(() => Transactions(
                                      nomEnfant:
                                          paiement.prenom_eleve.toString(),
                                      classe: paiement.classe.toString()));
                                },
                              ),
                            ),
                            // SizedBox(
                            //   height: Get.height * 0.01,
                            // )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          // return Padding(
          //   padding: EdgeInsets.symmetric(
          //       vertical: MediaQuery.of(context).size.height * 0.4),
          //   child: const Center(child: Text('Vos récentes transactions apparaîtront ici')),
          // );
          return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/transactions.png'),
                          const Text("Vos récentes transactions apparaîtront ici")
                        ],
                      ),
                    );
        }
      },
    );
  }
}
