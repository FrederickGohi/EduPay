import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import '../../api/api.dart';
import '../../constantes/constantes.dart';
import '../../models/emploirdutemps.dart';

class EmploiDuTemps extends StatefulWidget {
  const EmploiDuTemps({super.key});

  @override
  State<EmploiDuTemps> createState() => _EmploiDuTempsState();
}

class _EmploiDuTempsState extends State<EmploiDuTemps>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  Future<List<Emploidutemps>> _getProfs() async {
    List<Emploidutemps> listProfs = [];
    var response = await http.post(
      Uri.parse(Api.getProfs),
      body: {
        // 'classe': widget.classe.toString(),
      },
    );
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);
      if (responseBody['success']) {
        for (var element in (responseBody['data'] as List)) {
          listProfs.add(Emploidutemps.fromJson(element));
        }
      }
      // inspect(responseBody);
    }
    return listProfs;
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emploi du temps'),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(
              text: 'Lundi',
            ),
            Tab(
              text: 'Mardi',
            ),
            Tab(
              text: 'Mercredi',
            ),
            Tab(
              text: 'Jeudi',
            ),
            Tab(
              text: 'Vendredi',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Center(
            child: _lundi(),
          ),
          Center(
            child: _mardi(),
          ),
          Center(
            child: _mercredi(),
          ),
          Center(
            child: _jeudi(),
          ),
          Center(
            child: _vendredi(),
          ),

          // Center(
          // child:
          // buildAll(),
          // ),
        ],
      ),
    );
  }

  Widget _lundi() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 8.0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.28,
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
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            // color: Couleurs.ButtonCouleur,
                          ),
                          child: Text(
                            'FRANCAIS',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Couleurs.ButtonCouleur,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.clock,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Heure de début - Heure de fin',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    '8H00 - 12H00',
                                    style: TextStyle(
                                      color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.white,
                                ),
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.user,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Prof.',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    'KOFFI FRANCK',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 8.0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.28,
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
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            // color: Couleurs.ButtonCouleur,
                          ),
                          child: Text(
                            'ANGLAIS',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Couleurs.ButtonCouleur,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.clock,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Heure de début - Heure de fin',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    '8H00 - 12H00',
                                    style: TextStyle(
                                      color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.white,
                                ),
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.user,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Prof.',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    'DOSSO MAMADOU',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 8.0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.28,
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
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            // color: Couleurs.ButtonCouleur,
                          ),
                          child: Text(
                            'MATHEMATIQUES',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Couleurs.ButtonCouleur,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.clock,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Heure de début - Heure de fin',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    '8H00 - 12H00',
                                    style: TextStyle(
                                      color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.white,
                                ),
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.user,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Prof.',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    'CHRIST YAPI FRANCK',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 8.0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.28,
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
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            // color: Couleurs.ButtonCouleur,
                          ),
                          child: Text(
                            'DROIT',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Couleurs.ButtonCouleur,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.clock,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Heure de début - Heure de fin',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    '8H00 - 12H00',
                                    style: TextStyle(
                                      color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.white,
                                ),
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.user,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Prof.',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    'KASSI JUSTINE',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
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

  Widget _mardi() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 8.0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.28,
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
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            // color: Couleurs.ButtonCouleur,
                          ),
                          child: Text(
                            'ECONOMIE',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Couleurs.ButtonCouleur,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.clock,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Heure de début - Heure de fin',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    '8H00 - 12H00',
                                    style: TextStyle(
                                      color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.white,
                                ),
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.user,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Prof.',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    'KOFFI FRANCK',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 8.0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.28,
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
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            // color: Couleurs.ButtonCouleur,
                          ),
                          child: Text(
                            'COMPTABILITE',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Couleurs.ButtonCouleur,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.clock,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Heure de début - Heure de fin',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    '8H00 - 12H00',
                                    style: TextStyle(
                                      color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.white,
                                ),
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.user,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Prof.',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    'DOSSO MAMADOU',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 8.0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.28,
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
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            // color: Couleurs.ButtonCouleur,
                          ),
                          child: Text(
                            'SVT',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Couleurs.ButtonCouleur,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.clock,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Heure de début - Heure de fin',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    '8H00 - 12H00',
                                    style: TextStyle(
                                      color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.white,
                                ),
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.user,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Prof.',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    'CHRIST YAPI FRANCK',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 8.0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.28,
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
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            // color: Couleurs.ButtonCouleur,
                          ),
                          child: Text(
                            'DROIT',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Couleurs.ButtonCouleur,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.clock,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Heure de début - Heure de fin',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    '8H00 - 12H00',
                                    style: TextStyle(
                                      color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.white,
                                ),
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.user,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Prof.',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    'KASSI JUSTINE',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
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

  Widget _mercredi() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 8.0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.28,
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
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            // color: Couleurs.ButtonCouleur,
                          ),
                          child: Text(
                            'EXCEL',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Couleurs.ButtonCouleur,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.clock,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Heure de début - Heure de fin',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    '8H00 - 12H00',
                                    style: TextStyle(
                                      color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.white,
                                ),
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.user,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Prof.',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    'KOFFI FRANCK',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 8.0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.28,
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
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            // color: Couleurs.ButtonCouleur,
                          ),
                          child: Text(
                            'MARKETING DIGITAL',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Couleurs.ButtonCouleur,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.clock,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Heure de début - Heure de fin',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    '8H00 - 12H00',
                                    style: TextStyle(
                                      color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.white,
                                ),
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.user,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Prof.',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    'DOSSO MAMADOU',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 8.0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.28,
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
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            // color: Couleurs.ButtonCouleur,
                          ),
                          child: Text(
                            'DROIT PRIVE',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Couleurs.ButtonCouleur,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.clock,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Heure de début - Heure de fin',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    '8H00 - 12H00',
                                    style: TextStyle(
                                      color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.white,
                                ),
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.user,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Prof.',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    'CHRIST YAPI FRANCK',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 8.0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.28,
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
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            // color: Couleurs.ButtonCouleur,
                          ),
                          child: Text(
                            'WORD',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Couleurs.ButtonCouleur,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.clock,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Heure de début - Heure de fin',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    '8H00 - 12H00',
                                    style: TextStyle(
                                      color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.white,
                                ),
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.user,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Prof.',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    'KASSI JUSTINE',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
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

  Widget _jeudi() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 8.0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.28,
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
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            // color: Couleurs.ButtonCouleur,
                          ),
                          child: Text(
                            'FRANCAIS',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Couleurs.ButtonCouleur,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.clock,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Heure de début - Heure de fin',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    '8H00 - 12H00',
                                    style: TextStyle(
                                      color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.white,
                                ),
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.user,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Prof.',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    'KOFFI FRANCK',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 8.0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.28,
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
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            // color: Couleurs.ButtonCouleur,
                          ),
                          child: Text(
                            'ANGLAIS',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Couleurs.ButtonCouleur,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.clock,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Heure de début - Heure de fin',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    '8H00 - 12H00',
                                    style: TextStyle(
                                      color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.white,
                                ),
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.user,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Prof.',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    'DOSSO MAMADOU',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 8.0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.28,
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
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            // color: Couleurs.ButtonCouleur,
                          ),
                          child: Text(
                            'MATHEMATIQUES',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Couleurs.ButtonCouleur,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.clock,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Heure de début - Heure de fin',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    '8H00 - 12H00',
                                    style: TextStyle(
                                      color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.white,
                                ),
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.user,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Prof.',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    'CHRIST YAPI FRANCK',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 8.0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.28,
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
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            // color: Couleurs.ButtonCouleur,
                          ),
                          child: Text(
                            'DROIT',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Couleurs.ButtonCouleur,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.clock,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Heure de début - Heure de fin',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    '8H00 - 12H00',
                                    style: TextStyle(
                                      color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.white,
                                ),
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.user,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Prof.',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    'KASSI JUSTINE',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
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

  Widget _vendredi() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 8.0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.28,
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
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            // color: Couleurs.ButtonCouleur,
                          ),
                          child: Text(
                            'SPORT',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Couleurs.ButtonCouleur,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.clock,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Heure de début - Heure de fin',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    '8H00 - 12H00',
                                    style: TextStyle(
                                      color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.white,
                                ),
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.user,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Prof.',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    'KOFFI FRANCK',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 8.0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.28,
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
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            // color: Couleurs.ButtonCouleur,
                          ),
                          child: Text(
                            'HISOITRE - GEOGRAPHIE',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Couleurs.ButtonCouleur,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.clock,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Heure de début - Heure de fin',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    '8H00 - 12H00',
                                    style: TextStyle(
                                      color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.white,
                                ),
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.user,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Prof.',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    'DOSSO MAMADOU',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 8.0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.28,
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
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            // color: Couleurs.ButtonCouleur,
                          ),
                          child: Text(
                            'MATHEMATIQUES',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Couleurs.ButtonCouleur,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.clock,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Heure de début - Heure de fin',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    '8H00 - 12H00',
                                    style: TextStyle(
                                      color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.white,
                                ),
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.user,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Prof.',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    'CHRIST YAPI FRANCK',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0)),
              elevation: 8.0,
              child: Container(
                height: MediaQuery.of(context).size.height * 0.28,
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
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            // color: Couleurs.ButtonCouleur,
                          ),
                          child: Text(
                            'DROIT',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.05),
                          ),
                        ),
                        Expanded(
                            child: Container(
                          height: MediaQuery.of(context).size.height * 0.04,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Couleurs.ButtonCouleur,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Column(
                              children: [
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.clock,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Heure de début - Heure de fin',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    '8H00 - 12H00',
                                    style: TextStyle(
                                      color: Colors.white,
                                      // fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Divider(
                                  color: Colors.white,
                                ),
                                ListTile(
                                  leading: CircleAvatar(
                                    child: FaIcon(
                                      FontAwesomeIcons.user,
                                      size: 22,
                                    ),
                                  ),
                                  title: Text(
                                    'Prof.',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  subtitle: Text(
                                    'KASSI JUSTINE',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
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
