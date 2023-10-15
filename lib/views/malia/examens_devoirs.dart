import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../api/api.dart';
import '../../constantes/constantes.dart';
import '../../models/devoirs.dart';
import '../../models/examens_devoir.dart';
import '../../models/examen.dart';
import '../operations.dart';

class ExamenDevoir extends StatefulWidget {
  final String classe;
  const ExamenDevoir({Key? key, required this.classe});

  @override
  State<ExamenDevoir> createState() => _ExamenDevoirState();
}

class _ExamenDevoirState extends State<ExamenDevoir>
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

  Future<List<Examens>> _getExamens() async {
    List<Examens> listExamens = [];
    var response = await http.post(
      Uri.parse(Api.getExamens),
      body: {
        'classe': widget.classe.toString(),
      },
    );
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      if (responseBody['success']) {
        for (var element in (responseBody['data'] as List)) {
          listExamens.add(Examens.fromJson(element));
        }
      }
      // inspect(responseBody);
    }
    return listExamens;
  }

  Future<List<Devoirs>> _getDevoirs() async {
    List<Devoirs> listDevoirs = [];
    var response = await http.post(
      Uri.parse(Api.getDevoirs),
      body: {
        // 'id_eleve': 1,
        // 'id_classe': 1,
      },
    );
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      if (responseBody['success']) {
        for (var element in (responseBody['data'] as List)) {
          listDevoirs.add(Devoirs.fromJson(element));
        }
      }
      // inspect(responseBody);
    }
    return listDevoirs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 236, 236, 236),
      appBar: AppBar(
        title: Text(
          "Classe : ${widget.classe}",
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              text: 'Examens',
            ),
            Tab(
              text: 'Devoirs',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: _buildTabExamens(),
          ),
          Center(
            child: _buildTabDevoirs(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabExamens() {
    return FutureBuilder<List<dynamic>>(
      future: _getExamens(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List? data = snapshot.data;
          return ListView.builder(
            itemCount: data!.length,
            itemBuilder: (context, index) {
              Examens examen = snapshot.data![index];
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  elevation: 8.0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      // color: Couleurs.EndCouleur,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.05,
                              // color: Colors.blueGrey,
                              child: Text(examen.matiere,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Expanded(
                                child: Container(
                              height: MediaQuery.of(context).size.height * 0.04,
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Couleurs.ButtonCouleur,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.event,
                                      color: Colors.white,
                                      size: MediaQuery.of(context).size.width *
                                          0.08,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Date : ${examen.date}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
              // ListTile(
              //   title: Text(examen.libelle),
              // );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Failed to load data from API'),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Widget _buildTabDevoirs() {
    return FutureBuilder<List<dynamic>>(
      future: _getDevoirs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List? data = snapshot.data;
          return ListView.builder(
            itemCount: data!.length,
            itemBuilder: (context, index) {
              Devoirs devoirs = snapshot.data![index];
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  elevation: 8.0,
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.15,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                      // color: Couleurs.EndCouleur,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height * 0.05,
                              // color: Colors.blueGrey,
                              child: Text(devoirs.matiere,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.05,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Expanded(
                                child: Container(
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                color: Couleurs.ButtonCouleur,
                              ),
                              height: MediaQuery.of(context).size.height * 0.04,
                              // color: Couleurs.CouleurSecondaire,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.event,
                                      color: Colors.white,
                                      size: MediaQuery.of(context).size.width *
                                          0.08,
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Date : ${devoirs.date}',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10.0),
                                          child: Text(
                                            'H : ${devoirs.heure_debut}',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ))
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
              // ListTile(
              //   title: Text(examen.libelle),
              // );
            },
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Failed to load data from API'),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
