import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../api/api.dart';
import '../../constantes/constantes.dart';
import '../../controllers/c_user.dart';
import '../../modelss/paiements_details.dart';
import 'detail_transaction.dart';

class Transactions extends StatefulWidget {
  final String nomEnfant;
  final String classe;

  const Transactions({Key? key, required this.nomEnfant, required this.classe})
      : super(key: key);

  @override
  State<Transactions> createState() => _TransactionsState();
}

class _TransactionsState extends State<Transactions>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final _cUser = Get.put(CUser());
  Map ecole_classe = {};
  Map l_ecole = {};
  Map la_classe = {};
  var l_enfant;

  Future<List<PaiementDetails>> getPaiement() async {
    List<PaiementDetails> listPaiement = [];
    var idUser = _cUser.user.id_user.toString();
    var response = await http.post(
      Uri.parse(Api.getAllPayment),
      body: {
        'iduser': idUser,
        // 'type': widget.type.toString(),
        'nom': widget.nomEnfant.toString(),
      },
    );
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      // inspect(responseBody);
      if (responseBody['success']) {
        for (var element in (responseBody['data'] as List)) {
          listPaiement.add(PaiementDetails.fromJson(element));
        }
      }
    }
    return listPaiement;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${widget.nomEnfant.toString()} - ${widget.classe.toString()}"),
        // Text("${widget.nomEnfant.toString()} ${widget.classe.toString()}"),
      ),
      body: Center(child: buildAll()),
    );
  }

  Widget buildAll() {
    return FutureBuilder(
      future: getPaiement(),
      builder: (context, AsyncSnapshot<List<PaiementDetails>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
              child: CircularProgressIndicator(
            color: Theme.of(context).buttonTheme.colorScheme!.primaryContainer,
          ));
        }
        if (snapshot.data == null) {
          return const Center(child: Text('Echec de la connexion'));
        }
        if (snapshot.data!.isNotEmpty) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 10),
                  // color: Colors.amber,
                  height: MediaQuery.of(context).size.height * 1,
                  child: ListView.builder(
                    // scrollDirection: Axis.vertical,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      PaiementDetails paiementdetails = snapshot.data![index];
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 0),
                              child: ListTile(
                                leading: const CircleAvatar(
                                    child: Icon(
                                  Icons.attach_money,
                                  color: Colors.white,
                                  // color: Couleurs.CouleurPrimaire,
                                )),
                                trailing: const Icon(
                                  Icons.keyboard_arrow_right_sharp,
                                  color: Colors.grey,
                                  size: 20,
                                ),
                                title: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${paiementdetails.prenomEleve } ${paiementdetails.nomEleve }",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w900),
                                    ),
                                    Text(
                                      '${paiementdetails.montant.toString()} F CFA',
                                    ),
                                    Text(paiementdetails.dateTransaction),
                                  ],
                                ),
                                onTap: (() {
                                  // var data = widget.data;

                                  setState(() {
                                    la_classe = {
                                      'libelle': paiementdetails.classe,
                                    };
                                  });

                                  Get.to(
                                    () => DetailsTransaction(
                                      enfant: l_enfant,
                                      paiementDetails: paiementdetails,
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                )
              ],
            ),
          );
        } else {
          return const Center(child: Text('Historique des transactions'));
        }
      },
    );
  }
}
